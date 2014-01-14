require 'rspec'
require './lib/cart'
require './lib/store'
#require 'ruby-debug'

describe 'Cart' do
  #before(:each) do
  #  @aStore1 = (Store::Store.new).add_product('a', 1)
  #  @aCart1 = Cart::Cart.new(@aStore1)
  #end
  def new_Cart_with_StoreHavingProduct(aProductId=nil, aPrice=1)
    store = Store::Store.new
    store.add_product(aProductId, aPrice) if !aProductId.nil?
    cart = Cart::Cart.new(store)
    return cart, store
  end

  #let(:aCart0) { Cart::Cart.new( Store::Store.new ) }
  #let(:aCart1) { Cart_with_StoreHavingProductA }

  it '#add  add a new item.' do
    aCart0, aStore0 = new_Cart_with_StoreHavingProduct(nil)
    expect(aStore0.report).to eq("[]")
    aCart1, aStore1 = new_Cart_with_StoreHavingProduct('a')
    expect(aStore1.report).to eq("[{:id=>\"a\", :price=>100, :numberForBatchDiscount=>0, :batchPrice=>0}]")
    print (aCart1.report)
    aCart1.add('a')
    #debugger
    print (aCart1.report)
    expect{aCart1.add('b')}.to raise_error "Error, Your product could not be found in the store. Please re-enter."
    # RuntimeError" #"
  end

  it '#add  add a new item.' do
    pending 'let is not working with fcn'
    expect{aCart1.add('a')}.to raise_error ArgumentError
  end
end