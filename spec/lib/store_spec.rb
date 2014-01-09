require 'rspec'
require './lib/store'

describe 'Store' do
  let(:aStore) { Store::Store.new }

  # context "#Discounted Item - Features:" do
  it '#add Raises error if discount quantity but not price is entered.' do
    expect{aStore.add('a',1,3)}.to raise_error  "Argument aBatchPrice is empty." # RuntimeError
  end


  #end

  context "#Non-Discounted Item - Features:" do

    it '#add Raises error if add a new item without any arguments, ie no Id.' do
      expect{aStore.add()}.to raise_error ArgumentError
    end

    it '#add Raises error if add a new item without both Id and Price.' do
      expect{aStore.add('a')}.to raise_error ArgumentError
    end

    it '#count is 1 for one element.' do
      expect(aStore.count).to eq(0)
      aStore.add('a', 1)
      expect(aStore.count).to eq(1)
    end

    it '#count is 2 for two elements.' do
      expect(aStore.count).to eq(0)
      aStore.add('a', 1)
      aStore.add('b',2)
      expect(aStore.count).to eq(2)
    end

    it '#clear Resets a populated store back to empty.' do
      aStore.add('a', 1)
      expect{c}.not_to be_nil
      aStore.clear()
      expect(aStore.report()).to match /\[\]/
    end

    it '#report Describes its contents as a string.' do
      aStore.add('a', 1)
      expect(aStore.report).to eq('[{:id=>"a", :price=>1, :numberForBatchDiscount=>0, :batchPrice=>0}]')
    end

    it '#report Describes an empty store as having no elements.' do
      expect(aStore.report).to eq("[]")
    end
  end


end