# C:\amsrc\rmtry\lib\cart.rb
require './lib/store'
module Cart
  class Cart
    attr_reader :store, :products #not r/w  attr_accessor
    def initialize(aStore)
      @store = aStore
      @products = []
    end

    def add(aItemId)
      print (@store.to_s)
      raise "Error, Your product could not be found in the store. Please re-enter."   if !@store.find_product(aItemId)
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