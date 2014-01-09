# C:\amsrc\rmtry\lib\cart.rb
module Cart
  class Cart
    attr_reader :items #not r/w  attr_accessor
    def initialize()
      @items = []
    end

    def add(aItemId)
      @items = @items << aItemId
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