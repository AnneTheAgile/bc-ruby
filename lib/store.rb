# C:\amsrc\rmtry\lib\store.rb
require './lib/cart'

module Store
  class Store
    attr_reader :products , :cart #not r/w  attr_accessor
    def initialize()
      @products = []
      @cart = Cart::Cart.new
    end

    def validate_product(aItemId, aPrice, aMinimumBatchQuantity, aBatchPrice)
      raise "Argument aItemId is non-string."   if !aItemId.kind_of?(String)

      raise "Argument aPrice is non-numeric."   if !aPrice.kind_of?(Numeric)
      raise "Argument aPrice is negative."      if aPrice.abs != aPrice

      raise "Argument aMinimumBatchQuantity is non-numeric."   if !aMinimumBatchQuantity.kind_of?(Numeric)
      raise "Argument aMinimumBatchQuantity is non-integer (expecting number of items)."   if !aMinimumBatchQuantity.kind_of?(Integer)
      raise "Argument aMinimumBatchQuantity is negative."   if aMinimumBatchQuantity.abs != aMinimumBatchQuantity

      raise "Argument aBatchPrice is non-numeric."   if  !aBatchPrice.kind_of?(Numeric)
      raise "Argument aBatchPrice is negative."   if aBatchPrice.abs != aBatchPrice
      raise "Argument aBatchPrice was not specified but aMinimumBatchQuantity was."   if ( aBatchPrice == 0 and aMinimumBatchQuantity != 0 )
    end

    def add_product(aItemId, aPrice, aMinimumBatchQuantity=0, aBatchPrice=0)
      aPrice = convertDollarsToPennies(aPrice)
      aBatchPrice = convertDollarsToPennies(aBatchPrice)
      validate_product(aItemId, aPrice, aMinimumBatchQuantity, aBatchPrice)
      h = Hash[ :id=> aItemId, :price=> aPrice,
                :numberForBatchDiscount => aMinimumBatchQuantity,
                :batchPrice=> aBatchPrice
      ]
      @products = @products <<   h
    end

    def convertDollarsToPennies(aPrice)
      return (aPrice * 100).round
    end

    def clear_products_list()
      @products = []
    end

    def count_products()
      @products.size
    end

    def product_list_showing_prices_in_pennies
      @products.to_s
    end

  end
end