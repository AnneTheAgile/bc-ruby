module Money

  # Convert and manipulate US currency money (USD), as either dollars, eg 1.57, or pennies, eg 157.
  class Money
    attr_reader :pennies, :dollars

    def self.kPenniesPerDollar
      100.to_f
    end

    def initialize()
      @pennies = 0
      @dollars = 0
    end

    # Tell the current @dollars value as a string including the $ prefix, with no padding.
    def report_dollars(aDollars=@dollars)
      # http://stackoverflow.com/questions/4974812/how-do-i-force-a-number-to-10-decimal-places-in-ruby-on-rails
      float = aDollars
      "$" + "%0.2f" %float
    end

    # Increment both 1.The quantity of @pennies given the quantity of dollars; for example Pennies(1.507)=151; and 2.The @dollars to two decimal places.
    def add(aUsdAmount)
      @pennies = @pennies + dollarsToPennies(aUsdAmount)
      @dollars = @dollars + roundDollarsToFullCents(aUsdAmount)
    end

    # Validate and then Convert the given aUsdAmount to pennies, rounding up and returning float.
    def dollarsToPennies(aUsdAmount)
      validAsDollars(aUsdAmount)
      # Ruby needs to_f, ie float, to ensure result of division is a float.
      ((aUsdAmount.to_f)*Money.kPenniesPerDollar).round
    end

    # Returns at most two decimal places of accuracy.
    def roundDollarsToFullCents(aUsdAmount)
      # Ruby needs to-float to ensure result of division is a float.
      (dollarsToPennies(aUsdAmount)) / Money.kPenniesPerDollar
    end

    # Throws error if the given aUsdAmount is not convertible, positive, and finite.
    def validAsDollars(aUsdAmount)
      validAsNonNegativeFiniteNumber(aUsdAmount)
      begin
        Float(aUsdAmount)
      rescue
        raise "Argument #{aUsdAmount} is not convertible to a float."
      end
    end

    # Throws error if the given aQuantity is not a positive integer.
    def validAsPennies(aQuantity)
      validAsNonNegativeFiniteNumber(aQuantity)
    end

    # Throws error if false.
    def validAsNonNegativeFiniteNumber(aQuantity)
      begin
        Integer(aQuantity) # Truncates floats, refuses strings, unlike to_i and to_f.
      rescue
        raise "Argument #{aQuantity} is not convertible to an integer."
      end
      raise "Argument #{aQuantity} is negative." if aQuantity.to_f != aQuantity.to_f.abs
      raise "Argument #{aQuantity} is infinite." if aQuantity.to_f.infinite?
    end

    def penniesToDollars(aNbrOfPennies)
      validAsPennies(aNbrOfPennies)
      aNbrOfPennies.to_f / Money.kPenniesPerDollar
    end

  end
end