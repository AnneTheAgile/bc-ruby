require 'rspec'
require './lib/gifts'

describe 'Gifts/' do

  it 'Is null at first.' do
    g = Gifts::Gifts.new('m')
    expect(g.tellgifts).to eq("[\"m\"]")
  end

  it 'Can to_s.' do
    pending '!!Add crud test'
  end

end