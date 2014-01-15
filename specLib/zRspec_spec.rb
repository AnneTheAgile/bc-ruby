require 'rspec'
require 'logger'
require './custom_stdout_matcher'

describe 'zRuby/Rspec-Tips' do

  it 'Match, either prefix or postfix, does Regex matching strings.' do
    expect(/ab/).to match("aaabbb")
    expect("aaabbb").to match(/ab/)
  end

  it 'Throws NoMethodError (not NotImplementedError) with space before object of expect - So Avoid "expect (x)" - FUTURE, fix BUG in Cheatsheet.' do
    expect{expect ('0').to eq('1')}.to raise_error NoMethodError
  end

  xit 'Will not run any "it" test that is changed to "xit".'

  it 'Will not run and will explain the cause for delay when use a given pending clause plus text.' do
    pending 'Not implementing this to make an example.'
  end

  it 'Must call the bat file, not Rspec, on windows,' do
    expect('$ /cygdrive/c/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/bin/rspec.bat'[0]).to eq('$')
  end

  it 'Evaluates contents between parens (1+2), not needing a block {1+2}.' do
    expect(1+2).to eq(3)
  end

end

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

describe 'zRuby/Rspec/FUTURE' do
  it "Can Require a 'random' item with relative path." do
    pending 'Read up on the actual code to sort this out.'
    #require './custom_stdout_matcher'
    # idk how to get this working if i put the folder under spec.
    #'C:\amsrc\rmtry\spec\specLib\custom_stdout_matcher'
    #'./specLib/custom_stdout_matcher'
  end

  it "Can be run from CLI with a particular path, eg specLib." do
    pending 'On windows, chk commandline and/or path and/or the raw code.'
=begin
    C:\amsrc\rmtry>C:\Users\amoroney\amApps\lang\ruby\RailsInstaller\Ruby1.9.3\bin
    /rspec .\specLib --format doc
C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require': cannot load such file -- ./custom_stdout_matcher (LoadError)
        from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
        from C:/amsrc/rmtry/specLib/zRspec_spec.rb:3:in `<top (required)>'
    from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/configuration.rb:886:in `load'
        from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/configuration.rb:886:in `block in load_spec_files'
        from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/configuration.rb:886:in `each'
    from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/configuration.rb:886:in `load_spec_files'
        from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/command_line.rb:22:in `run'
        from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/runner.rb:90:in `run'
    from C:/Users/amoroney/amApps/lang/ruby/RailsInstaller/Ruby1.9.3/lib/ruby/gems/1.9.1/gems/rspec-core-3.0.0.beta1/lib/rspec/core/runner.rb:17:in `block in autorun'

C:\amsrc\rmtry>
=end
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
