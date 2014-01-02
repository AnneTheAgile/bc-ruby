require 'rspec'
require './lib/gifts'

describe 'Buy' do

  it 'is null at first' do
    g = Gifts::Gifts.new('m')
    expect(g.tellgifts).to eq('h')
  end
  #failure/Error: expect(g.tellgifts).to eq('h')
  #
  #expected: "h"
  #got: "[\"m\"]"`

  it 'should tell buyer its glam' do
    pending 'todo add crud test'
    #true.should == false
  end
end