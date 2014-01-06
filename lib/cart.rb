# C:\Users\amoroney\amPrjs\rmtry\lib\cart.rb
module Cart
  class Cart
    attr_accessor :items

    def initialize()
      @items = []
    end

    def add(aItemId, aPrice)
      @items = [] << aItemId #append array
    end

    def report
      @items.to_s
    end

  end
end