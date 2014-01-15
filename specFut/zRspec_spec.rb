require 'rspec'
require 'rspec'
require 'logger'
require './specLib/custom_stdout_matcher'

describe 'Rspec Normal Matchers' do
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

  it 'Regex match_stdout is case-insensitive and finds substrings, so insensitive to start/end of line.' do
    aStr = "Hello from your POS Terminal Controller!"
    expect { print (aStr) }.to match_stdout( "Hello from your POS") #" Terminal Controller!")
    expect { print (aStr) }.to match_stdout( "from")
    expect { print (aStr) }.not_to match_stdout( "hello")
  end

end


#Module Matchers
RSpec::Matchers.define :have_errors_on do |expectThing|
  match do |blockToTest|
    blockToTest==expectThing
  end
end
#end
=begin


# Custom Matcher to test contents of console output contains the given text.
# This is case-sensitive, but searches for a substring.
# Example Rspec;   expect { some_code }.to match_stdout( 'some string' )
# Author; MindTheMonkey Dec 14 '13, URL:
# http://stackoverflow.com/questions/6372763/rspec-how-do-i-write-a-test-that-expects-certain-output-but-doesnt-care-about
RSpec::Matchers.define :match_stdout do |check|

  @capture = nil

match do |block|

  begin
    stdout_saved = $stdout
    $stdout      = StringIO.new
    block.call
  ensure
    @capture     = $stdout
    $stdout      = stdout_saved
  end

  @capture.string.match check
end

failure_message_for_should do
  "expected to #{description}"
end
failure_message_for_should_not do
  "expected not to #{description}"
end
description do
  "match [#{check}] on stdout [#{@capture.string}]"
end

end
=end
