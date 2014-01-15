require 'rspec'
require '.lib/product'

describe Product do
  let(:aStore) { Store::Store.new }

  it 'Initializes and constructs a returned map.' do
    p = Product::Product.new(:id=>'a',)
    expect(true) == false
  end
end