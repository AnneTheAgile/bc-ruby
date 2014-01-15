Module Product
  class Product
    attr_reader :product, :id, :price, :numberForBatchDiscount, :batchPrice
    attr_reader :products, :cart #not r/w  attr_accessor

    def initialize(** args)
      @product = Hash.new(args)
    end

  end
end