require 'rspec'

describe "Rspec Custom Matchers" do

  #-----------------------
  #module Matchers
  RSpec::Matchers.define :have_errors_on do |expectThing|
    match do |blockToTest|
      blockToTest!=expectThing
    end
  end
#end

  it 'Custom match equals ok ---Regex matches throw.' do
    expect{'a'}.to have_errors_on{a=1}
  end

end