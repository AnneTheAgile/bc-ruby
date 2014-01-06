require 'rspec'
require './lib/cart'

describe 'Cart/' do

  it 'Raises error to add a new gift without both giftId and price.' do
    c = Cart::Cart.new
    expect{c.add('m')}.to raise_error ArgumentError
  end

  it 'Reports its contents as a string.' do
    g =  Cart::Cart.new
    g.add('m', 1)
    expect(g.report).to eq("[\"m\"]")
  end

end