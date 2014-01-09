# C:\amsrc\rmtry\lib\cart.rb
module Cart
  class Cart
    attr_reader :items #not r/w  attr_accessor
    def initialize()
      @products = []
    end

    def add(aItemId)
      @products = @products << aItemId
    end

    def clear()
      @products = []
    end

    def count()
      @products.size
    end

    def report
      @products.to_s
    end

  end
end