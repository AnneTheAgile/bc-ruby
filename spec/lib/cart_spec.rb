require 'rspec'
require './lib/cart'

describe 'Cart/' do
  let(:aCart) { Cart::Cart.new }

    before :each do
    # aCart = Cart::Cart.new
    end

  # context "#When Populated - Features:" do
    it '#add Raises error if add a new item without any arguments, ie no Id.' do
      expect{aCart.add()}.to raise_error ArgumentError
    end

    it '#add Raises error if add a new item without both Id and Price.' do
      expect{aCart.add('a')}.to raise_error ArgumentError
    end

    it '#count is 1 for one element.' do
      expect(aCart.count).to eq(0)
      aCart.add('a', 1)
      expect(aCart.count).to eq(1)
    end

    it '#count is 2 for two elements.' do
      expect(aCart.count).to eq(0)
      aCart.add('a', 1)
      aCart.add('b',2)
      expect(aCart.count).to eq(2)
    end

    it '#report Describes its contents as a string.' do
      aCart.add('a', 1)
      expect(aCart.report).to eq('[{:id=>"a", :price=>1, :numberForBatchDiscount=>0, :batchPrice=>0}]')
    end

  it '#clear Resets a populated cart back to empty.' do
    aCart.add('a', 1)
    expect{c}.not_to be_nil
    aCart.clear()
    expect(aCart.report()).to match /\[\]/
  end
#end

 # context "#When Empty - Features:" do

    it '#report Describes an empty cart as having no elements.' do
      g =  Cart::Cart.new
      expect(g.report).to eq("[]")
    end
 # end


end