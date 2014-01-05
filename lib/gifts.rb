# C:\Users\amoroney\amPrjs\rmtry\lib\gifts.rb
module Gifts
  class Gifts

    def initialize(aGift)
      @thegifts = [] << aGift #append array
    end

    def tellgifts
      @thegifts.to_s
    end

  end
end