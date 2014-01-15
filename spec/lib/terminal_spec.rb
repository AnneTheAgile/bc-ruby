require 'rspec' # core, expectations, mocks, support
require './lib/terminal'
require './lib/store'
require './lib/cart'

describe 'Terminal/Shopping/' do
  let(:theStore) { Store::Store.new }

  #  describe '#Startup-initialization' do
      it 'Says Hello to the (Admin) user upon instantiation.' do
        expect { Terminal::TerminalPos.new() }.to match_stdout( "Hello from your POS") #" Terminal Controller!")
      end

      it 'Does Not accept a redefined $stdin nor $stdout.' do
        expect{Terminal::TerminalPos.new($stdin)}.to  raise_error ArgumentError
      end

      context 'TBA' do

      it 'asks for product pricelist.'

      it 'allows entry of product-id, price'

      it 'allows entry of product-id, price, qualifying quantity, and discounted price'

      it 'verifies item added to a cart is in the store.' do
        pending '(first dependency)'
      end
      end

  end

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