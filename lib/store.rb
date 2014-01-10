# C:\amsrc\rmtry\lib\store.rb
require './lib/cart'

module Store
  class Store
    attr_reader :products , :cart #not r/w  attr_accessor

    def initialize()
      @products = []
      @cart = Cart::Cart.new
    end

    def add_product(aItemId, aPrice, aMinimumBatchQuantity=0, aBatchPrice=0)
      aBatchPrice, aPrice = convert_and_validate_product(aBatchPrice, aItemId, aMinimumBatchQuantity, aPrice)
      @products = @products <<   Hash[ :id=> aItemId, :price=> aPrice,
                                       :numberForBatchDiscount => aMinimumBatchQuantity,
                                       :batchPrice=> aBatchPrice
      ]
    end

    def convert_and_validate_product(aBatchPrice, aItemId, aMinimumBatchQuantity, aPrice)
      aBatchPrice = convertDollarsToPennies(aBatchPrice)
      aPrice = convertDollarsToPennies(aPrice)

      validate_string(aItemId)
      validate_positive_number(aPrice)
      validate_integer_ge_zero(aMinimumBatchQuantity)
      validate_sensible_discount(aBatchPrice, aMinimumBatchQuantity)
      return aBatchPrice, aPrice
    end

    def convertDollarsToPennies(aPrice)
      validate_positive_number(aPrice)
      return (aPrice * 100).round
    end

    def validate_positive_number(aPrice)
      raise "Argument aPrice is non-numeric."   if !aPrice.kind_of?(Numeric)
      raise "Argument aPrice is negative."      if aPrice.abs != aPrice
    end

    def validate_string(aItemId=nil)
      raise "Argument aItemId is non-string."   if !aItemId.kind_of?(String)
    end

    def validate_sensible_discount(aBatchPrice, aMinimumBatchQuantity)
      raise "Argument aBatchPrice was not specified but aMinimumBatchQuantity was." if (aBatchPrice == 0 and aMinimumBatchQuantity != 0)
      validate_positive_number(aBatchPrice)     if aMinimumBatchQuantity != 0
    end

    def validate_integer_ge_zero(aNum)
      raise "Argument aNum is non-numeric."   if !aNum.kind_of?(Numeric)
      raise "Argument aNum is negative."      if aNum.abs != aNum
      raise "Argument aNum is non-integer."   if !aNum.kind_of?(Integer)
    end

    def clear_products_list()
      @products = []
    end

    def count_products()
      @products.size
    end

    def find_product (aProductId)
      begin
        validate_string(aProductId)
      rescue
        return false
      end
      @products.each { |aMap|   return true if aMap[:id]==aProductId }
      false
    end

    def product_list_showing_prices_in_pennies
      @products.to_s
    end

  end
end