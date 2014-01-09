require 'rspec'
require './lib/cart'
require './lib/store'

describe 'Cart' do
  let(:aCart) { Cart::Cart.new }

  context "#Using the Store, Buy items - Features:" do

    it '#add Raises error if add a new item without any arguments, ie no Id.' do
      expect{aCart.add()}.to raise_error ArgumentError
    end

    it '#count is 1 for one element.' do
      expect(aCart.count).to eq(0)
      aCart.add('a')
      expect(aCart.count).to eq(1)
    end

    it '#count is 2 for two elements.' do
      expect(aCart.count).to eq(0)
      aCart.add('a')
      aCart.add('b')
      expect(aCart.count).to eq(2)
    end

    it '#clear Resets a populated cart back to empty.' do
      aCart.add('a')
      expect{c}.not_to be_nil
      aCart.clear()
      expect(aCart.report).to match /\[\]/
    end

    it '#report Describes contents of one item as a string.' do
      aCart.add('a')
      expect(aCart.report).to eq('["a"]')
    end

    it '#report Describes its contents of two items as a string.' do
      aCart.add('a')
      aCart.add('b')
      expect(aCart.report).to eq('["a", "b"]')
    end

    it '#report Describes an empty cart as having no elements.' do
      c =  Cart::Cart.new
      expect(c.report).to eq("[]")
    end
  end


end