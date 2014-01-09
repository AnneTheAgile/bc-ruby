require 'rspec'
require './lib/store'

describe 'Store' do
  let(:aStore) { Store::Store.new }

  # context "#Discounted Item - Features:" do
  it '#Add_Product Raises error if discount quantity but not price is entered.' do
    expect{aStore.add_product('a',1,3)}.to raise_error  "Argument aBatchPrice was not specified but aMinimumBatchQuantity was." # RuntimeError
  end

  it '#ConvertDollarsToPennies Rounds up.' do
    expect(aStore.convertDollarsToPennies(1.110)).to eql(111)
    expect(aStore.convertDollarsToPennies(1.111)).to eql(111)
    expect(aStore.convertDollarsToPennies(1.115)).to eql(112)
    expect(aStore.convertDollarsToPennies(1.117)).to eql(112)
  end


  #end

  context "#Non-Discounted Item - Features:" do

    it '#Add_Product Raises error if add a new item without any arguments, ie no Id.' do
      expect{aStore.add_product()}.to raise_error ArgumentError
    end


    it '#Add_to_Cart Raises error if add a product that is not in the store.'

    it '#Add_Product Raises error if add a new item without both Id and Price.' do
      expect{aStore.add_product('a')}.to raise_error ArgumentError
    end

    it '#count is 1 for one element.' do
      expect(aStore.count_products).to eq(0)
      aStore.add_product('a', 1)
      expect(aStore.count_products).to eq(1)
    end

    it '#count is 2 for two elements.' do
      expect(aStore.count_products).to eq(0)
      aStore.add_product('a', 1)
      aStore.add_product('b',2)
      expect(aStore.count_products).to eq(2)
    end

    it '#clear Resets a populated store back to empty.' do
      aStore.add_product('a', 1)
      expect{c}.not_to be_nil
      aStore.clear_products_list()
      expect(aStore.product_list_showing_prices_in_pennies()).to match /\[\]/
    end

    it '#report Describes its contents as a string.' do
      aStore.add_product('a', 1)
      expect(aStore.product_list_showing_prices_in_pennies).to eq('[{:id=>"a", :price=>100, :numberForBatchDiscount=>0, :batchPrice=>0}]')
    end

    it '#report Describes an empty store as having no elements.' do
      expect(aStore.product_list_showing_prices_in_pennies).to eq("[]")
    end
  end


end