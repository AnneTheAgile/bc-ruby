require 'rspec'
require 'rspec'
require 'logger'

#Module Matchers
RSpec::Matchers.define :have_errors_on do |expectThing|
  match do |blockToTest|
    blockToTest==expectThing
  end
end
#end
describe 'zRuby/Rspec-Custom-Matchers-Tips/' do

  it 'Custom match Trivial equals ok ---Regex matches throw.' do
    expect{'a'}.not_to have_errors_on{a=1}
  end

    it 'Match, either prefix or postfix, does Regex matching strings.' do
      expect(/ab/).to match("aaabbb")
      expect("aaabbb").to match(/ab/)
    end

    it 'Custom Regex match against a block, instead of crash.' do
      pending 'Language deficit, until: Be able to pass Block to a Regex, not just an Object, eg ; expect{"aaabbb"}.to match(/ab/)'
    end

end
