# C:\amsrc\rmtry\lib\cart.rb
require './lib/store'
module Cart
  # A collection of pending purchases is stored in a Cart.
  class Cart
    attr_reader :store, :products #not r/w  attr_accessor
    def initialize(aStore)
      @store = aStore
      @products = []
    end

    def add(aItemId)
      raise "Error, Your product could not be found in the store. Please re-enter."   if validate_item(aItemId)
      @products = @products << aItemId
    end

    def validate_item(aItemId)
      !@store.find_product?(aItemId)
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