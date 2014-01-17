require 'rspec/expectations'
# https://www.relishapp.com/rspec/rspec-expectations/v/2-8/docs/custom-matchers/define-matcher

#Module Matchers

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

# end # Module Matchers