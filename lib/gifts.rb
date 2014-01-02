# C:\Users\amoroney\amPrjs\rmtry\lib\gifts.rb
module Gifts
class Gifts
  def initialize(aGift)
    @thegifts=[] << aGift #append array
    print('initialize done!'+@thegifts.to_s+' cr;'+'\n')
  end
  def tellgifts
    @thegifts.to_s
  end
end
end