require 'rspec'
require './lib/db'

describe 'Db' do
  let(:aDb) { db::db.new }

  it '#count is 1 for one element.' do
    expect(aDb.count).to eq(0)
    aDb.add('a', 1)
    expect(aDb.count).to eq(1)
  end

  it '#count is 2 for two elements.' do
    expect(aDb.count).to eq(0)
    aDb.add('a', 1)
    aDb.add('b',2)
    expect(aDb.count).to eq(2)
  end

  it '#clear Resets a populated db back to empty.' do
    aDb.add('a', 1)
    expect{c}.not_to be_nil
    aDb.clear()
    expect(aDb.report()).to match /\[\]/
  end

  it '#report Describes its contents as a string.' do
    aDb.add('a', 1)
    expect(aDb.report).to eq('[{:id=>"a", :price=>1, :numberForBatchDiscount=>0, :batchPrice=>0}]')
  end

  it '#report Describes an empty db as having no elements.' do
    expect(aDb.report).to eq("[]")
  end


end