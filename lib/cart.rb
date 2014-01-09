# C:\Users\amoroney\amPrjs\rmtry\lib\cart.rb
module Cart
  class Cart
    attr_reader :items #not r/w  attr_accessor
    def initialize()
      @items = []
    end

    def add(aItemId, aPrice, aMinimumBatchQuantity=0, aBatchPrice=0)
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