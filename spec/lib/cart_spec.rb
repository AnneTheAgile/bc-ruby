require 'rspec'
require './lib/cart'
require './lib/store'


def StoreHavingProductA
  s = (Store::Store.new).add_product('a', 1)
end

describe 'Cart' do
  def new_Cart_with_StoreHavingProduct(aProduct1=nil, aProduct2=nil)
    store = Store::Store.new
    store.add_product(aProduct1, 1) if !aProduct1.nil?
    store.add_product(aProduct2, 1) if !aProduct2.nil?
    cart = Cart::Cart.new(store)
    return cart, store
  end

  context "Context: There is a Store associated with this Cart to check products." do

    it '#add Raises error if add a new item without any arguments, ie no Id.' do
      aCart0, aStore0 = new_Cart_with_StoreHavingProduct
      expect{aCart0.add()}.to raise_error ArgumentError
    end

    it '#count is 1 for one element.' do
      aCart1, aStore1 = new_Cart_with_StoreHavingProduct('a')
      aCart1.add('a')
      expect(aCart1.count).to eq(1)
    end

    it '#count is 2 for two elements.' do
      aCart, aStore = new_Cart_with_StoreHavingProduct('a','b')
      aCart.add('a')
      aCart.add('b')
      expect(aCart.count).to eq(2)
    end

    it '#clear Resets a populated cart back to empty.' do
      aCart1, aStore1 = new_Cart_with_StoreHavingProduct('a')
      expect{aCart1}.not_to be_nil
      aCart1.clear()
      expect(aCart1.report).to match /\[\]/
    end

    it '#report Describes contents of one item as a string.' do
      aCart1, aStore1 = new_Cart_with_StoreHavingProduct('a')
      aCart1.add('a')
      expect(aCart1.report).to eq('["a"]')
    end

    it '#report Describes its contents of two items as a string.' do
      aCart, aStore = new_Cart_with_StoreHavingProduct('a','b')
      aCart.add('a')
      aCart.add('b')
      expect(aCart.report).to eq('["a", "b"]')
    end

    it '#report Describes an empty cart as having no elements.' do
      aCart0, aStore0 = new_Cart_with_StoreHavingProduct
      expect(aCart0.report).to eq("[]")
    end
  end


end