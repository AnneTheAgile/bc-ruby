# C:\amsrc\rmtry\lib\store.rb
require './lib/cart'

module Store
  class Store
    attr_reader :items , :cart1 #not r/w  attr_accessor
    def initialize()
      @items = []
      @cart1 = Cart::Cart.new
    end

    def add(aItemId, aPrice, aMinimumBatchQuantity=0, aBatchPrice=0)
      raise "Argument aBatchPrice is empty."   if
        aMinimumBatchQuantity.nil? ? false :            aBatchPrice.is_a?(Numeric)

      h = Hash[ :id=> aItemId, :price=> aPrice,
                :numberForBatchDiscount => aMinimumBatchQuantity,
                :batchPrice=> aBatchPrice
      ]
      @items = @items <<   h
    end

    def clear()
      @items = []
    end

    def count()
      @items.size
    end

    def report
      @items.to_s
    end

  end
end