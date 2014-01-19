require 'rspec'
require './lib/pennies'

describe Pennies do

  let(:aPennies) { Pennies::Pennies.new }

  it '#Report_dollars prepends the $ to the current @dollars and includes two decimal places.' do
    aPennies.add(1.1)
    expect(aPennies.report_dollars).to eq("$1.10")
  end

  describe 'Can add monies, tracking both pennies and dollars.' do

    it '#Add 1 USD to 0 => 100 pennies = 1.00 dollars.' do
      aPennies.add(1)
      expect(aPennies.pennies).to eq(100)
      expect(aPennies.dollars).to eq(1.00)
    end

    it '#Add 0.01 USD, ie one penny, to 0 => 1 penny = 0.01 dollars.' do
      aPennies.add(0.01)
      expect(aPennies.pennies).to eq(1)
      expect(aPennies.dollars).to eq(0.01)
    end

    it '#Add 1.119 USD to 0 (rounds up) => 112 pennies = 1.12 dollars.' do
      aPennies.add(1.119)
      expect(aPennies.pennies).to eq(112)
      expect(aPennies.dollars).to eq(1.12)
    end

  end

  describe 'Can validate and convert between dollars and pennies.' do

    it '#Pennies_to_dollars uses the class constant to convert.' do
      expect(aPennies.penniesToDollars(700)*Pennies::Pennies.kPenniesPerDollar).to eq(700)
    end

    it '#Add and all Validators Raise error if provide a string instead of USD or pennies.' do
      expect{aPennies.add('a')}.to raise_error RuntimeError
      expect{aPennies.dollarsToPennies('a')}.to raise_error RuntimeError
      expect{aPennies.penniesToDollars('a')}.to raise_error RuntimeError
      expect{aPennies.roundDollarsToFullCents('a')}.to  raise_error RuntimeError
      expect{aPennies.validAsDollars('a')}.to  raise_error RuntimeError
      expect{aPennies.validAsPennies('a')}.to  raise_error RuntimeError
      expect{aPennies.validAsNonNegativeFiniteNumber('a')}.to  raise_error RuntimeError
    end

    it '#Add and all Validators Raise error if provide a negative number for USD or pennies.' do
      expect{aPennies.add(-1)}.to raise_error RuntimeError
      expect{aPennies.dollarsToPennies(-1)}.to raise_error RuntimeError
      expect{aPennies.penniesToDollars(-1)}.to raise_error RuntimeError
      expect{aPennies.roundDollarsToFullCents(-1)}.to  raise_error RuntimeError
      expect{aPennies.validAsDollars(-1)}.to  raise_error RuntimeError
      expect{aPennies.validAsPennies(-1)}.to  raise_error RuntimeError
      expect{aPennies.validAsNonNegativeFiniteNumber(-1)}.to  raise_error RuntimeError
    end

    it '#Add and all Validators Raise error if provide infinity for USD or pennies.' do
      # http://stackoverflow.com/questions/5778295/how-to-express-infinity-in-ruby
      expect{aPennies.add(+1.0/0.0)}.to raise_error RuntimeError
      expect{aPennies.dollarsToPennies(+1.0/0.0)}.to raise_error RuntimeError
      expect{aPennies.penniesToDollars(+1.0/0.0)}.to raise_error RuntimeError
      expect{aPennies.roundDollarsToFullCents(+1.0/0.0)}.to  raise_error RuntimeError
      expect{aPennies.validAsDollars(+1.0/0.0)}.to  raise_error RuntimeError
      expect{aPennies.validAsPennies(+1.0/0.0)}.to  raise_error RuntimeError
      expect{aPennies.validAsNonNegativeFiniteNumber(+1.0/0.0)}.to  raise_error RuntimeError
    end

    it '#DollarsToPennies Rounds up.' do
      expect(aPennies.dollarsToPennies(1.110)).to eql(111)
      expect(aPennies.dollarsToPennies(1.111)).to eql(111)
      expect(aPennies.dollarsToPennies(1.115)).to eql(112)
      expect(aPennies.dollarsToPennies(1.117)).to eql(112)
    end

  end

  describe 'FUTURE possible work.' do

    it 'Refactor: Use Class-based, not instance-based, methods for the Math functions.'

    it '#Add .1 USD, ie no leading zero, Raises Syntax error.' do
      pending 'Cannot directly test due to the error.'
      #expect(aPennies.add(.1)).to raise(syntax error)
    end

  end

end