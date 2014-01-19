# C:\amsrc\rmtry\lib\store.rb
require './lib/cart'
require './lib/store'
require './lib/money'

module Store

  # Product and Price list data, based dollars using whole pennies, are housed in the Store class.
  class Store

    def initialize()
      @products = []
    end

    def product_attributes
      [:id, :price, :batchPrice, :numberForBatchDiscount]
    end

    # To @products, add the given data as a map, where price is in dollars.
    def add_product(aItemId, aPrice, aMinimumBatchQuantity=0, aBatchPrice=0.0)
      validAsProduct(aItemId, aPrice, aMinimumBatchQuantity, aBatchPrice)
      new_item = Hash[
          :id=> aItemId,
          :price=> (Money::Money.new).add( aPrice),
          :numberForBatchDiscount => aMinimumBatchQuantity,
          :batchPrice=> (Money::Money.new).add( aBatchPrice)
      ]
      @products = @products << new_item
    end

    def validAsProduct(aItemId, aPrice, aMinimumBatchQuantity, aBatchPrice)
      validAsProductID(aItemId)
      raise "Duplicate products are not allowed in the store." if find_product?(aItemId)

      validAsRetailPrice(aPrice)
      validAsBatchQuantity(aMinimumBatchQuantity)
      validAsBatchPrice(aBatchPrice)
      validate_sensible_discount(aBatchPrice, aMinimumBatchQuantity)
    end

    def validate_sensible_discount(aBatchPrice, aMinimumBatchQuantity)
      raise "Argument aBatchPrice #{aBatchPrice} was not specified but aMinimumBatchQuantity #{aMinimumBatchQuantity} was." if (aBatchPrice == 0 and aMinimumBatchQuantity != 0)
    end

    # A valid product ID is a string of LT 5 characters.
    def validAsProductID (aStr)
      raise "Argument #{aStr} is not a string." if aStr.class != String
      raise "Argument #{aStr} is longer than 5 characters." if aStr.to_s.length > 5
      raise "Argument '#{aStr}' contains whitespace." if (aStr =~ /\s/) != nil
      raise "Argument '#{aStr}' contains special non-word characters." if (aStr =~ /\W/) != nil
    end

    def validAsBatchQuantity(aNumber)
      Money::Money.new.validAsNonNegativeFiniteNumber(aNumber)
    end

    def validAsRetailPrice(aPrice)
      validAsBatchPrice(aPrice)
      raise "Argument '#{aPrice}' must not be zero." if aPrice == 0
    end

    def validAsBatchPrice(aPrice)
      Money::Money.new.validAsDollars(aPrice)
    end

    def clear_products_list()
      @products = []
    end

    def count_products()
      @products.size
    end

    # Validate that the given aProductId is in the store. (Boolean)
    def find_product? (aProductId)
      return false if (find_product(aProductId) == {})
      return true
    end

    # Return the Product map for the given aProductId, if it is in the store, or the empty map, {}, if not.
    def find_product (aProductId)
      validAsProductID(aProductId) rescue return {}
      @products.each { |aMap|   return aMap if aMap[:id]==aProductId }
      return {}
    end

    def product_list_showing_prices_in_dollars
      @products.to_s
    end

    def report
      product_list_showing_prices_in_dollars
    end

    # Using the algorithm that only complete sets are discounted, any extra items are charged full price, get the total bill for the given quantity of the given product.
    def minimal_price_in_dollars(aProduct, aQtyToBuy)
      stdPrice = aProduct[:price]
      discPrice = aProduct[:batchPrice]
      discQty = aProduct[:numberForBatchDiscount]

      case discPrice
        when 0
          leftovers = aQtyToBuy
          batches = 0
        else
          leftovers = aQtyToBuy % discQty
          batches = (aQtyToBuy - leftovers) / discQty
      end
      price = (discPrice * batches) + (stdPrice * leftovers)
      #print "--rpt= #{aProduct}"
      #print "--minimal= (#{discPrice} * #{batches}) + (#{stdPrice} * #{leftovers}) == #{price}"
      price
    end

    # Return the total price for the given aQuantity of aId products and use the minimal discount.
    def price_in_dollars_for_quantity(aId, aQuantity=1)
      product = find_product(aId)
      raise "No such product." if product=={}
      return (minimal_price_in_dollars(product,aQuantity))
    end
  end
end