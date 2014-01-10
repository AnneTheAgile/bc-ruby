require 'rspec'

describe 'Rspec Usage' do
  it 'Can NOT test truth/false with be_true or be_false.' do
      a = ['a','b']
      expect(a.include?('a')).to eq(true) #WORKS
      expect{
        expect{a.include?('a')}.to be_true
      }.to raise_error(NoMethodError)   #OK
#      }.to raise_error(NoMethodError, /undefined method \`true?\'/)   #BUG
# expected NoMethodError with message matching /undefined method \`true?\'/, got #<NoMethodError: undefined method `true?' for #<Proc:0x007f90d30b2578>> with backtrace:
#      }.to raise_error(NoMethodError, /undefined method `true?'/)   BUG
#      }.to raise_error(/NoMethodError: undefined method \`true\?\' for \#\<Proc:0x007fca0c1dca80\>/)
#      }.to raise_error(NoMethodError, /undefined method `true?'/)
#      }.to raise_error("NoMethodError: undefined method `true?'" )
  end
end

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