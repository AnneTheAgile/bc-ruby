require 'rspec'
require './lib/db'

describe 'Db' do
  let(:aDb) { db::db.new }

  it '#count is 1 for one element.' do
    expect(aDb.count_products).to eq(0)
    aDb.add_product('a', 1)
    expect(aDb.count_products).to eq(1)
  end

  it '#count is 2 for two elements.' do
    expect(aDb.count_products).to eq(0)
    aDb.add_product('a', 1)
    aDb.add_product('b',2)
    expect(aDb.count_products).to eq(2)
  end

  it '#clear Resets a populated db back to empty.' do
    aDb.add_product('a', 1)
    expect{c}.not_to be_nil
    aDb.clear_products_list()
    expect(aDb.product_list_showing_prices_in_pennies()).to match /\[\]/
  end

  it '#report Describes its contents as a string.' do
    aDb.add_product('a', 1)
    expect(aDb.product_list_showing_prices_in_pennies).to eq('[{:id=>"a", :price=>1, :numberForBatchDiscount=>0, :batchPrice=>0}]')
  end

  it '#report Describes an empty db as having no elements.' do
    expect(aDb.product_list_showing_prices_in_pennies).to eq("[]")
  end


end