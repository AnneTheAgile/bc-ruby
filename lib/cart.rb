# C:\amsrc\rmtry\lib\cart.rb
require './lib/store'
require './lib/money'

module Cart
  # A place to collect pending purchases. (A Model)
  class Cart
    attr_reader :store, :products #not r/w  attr_accessor
    def initialize(aStore)
      @store = aStore
      @products = []
    end

    def add(aItemId)
      raise "Error, Your product could not be found in the store. Please re-enter. It was: #{aItemId.to_s}"   if validate_item(aItemId)
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

    def report_total
      Money::Money.new.report_dollars(totalPrice)
    end

    # Transform the list of products, which is unsorted and contains duplicates, into a map with zero quantities to start.
    def cartAsMapOfProductsAndQuantities
      aMap = @products.sort.each_with_object(Hash.new) {|i, m| m[i]+=1 rescue m[i]=1}
      #print(["-cartAsMap=",aMap.inspect,"\n"].join)
      aMap
    end

    def totalPrice
      items = cartAsMapOfProductsAndQuantities
      total = items.inject(0) {|aTotal, iPair| aTotal += @store.price_in_dollars_for_quantity(iPair[0], iPair[1]) }
    end

  end
end