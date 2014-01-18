require 'rspec' # core, expectations, mocks, support
require './lib/terminal'
require './lib/store'
require './lib/cart'
require './spec/lib/custom_stdout_matcher'

# http://stackoverflow.com/questions/20275510/how-to-avoid-deprecation-warning-for-stub-chain-in-rspec-3-0
RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe 'Terminal/Shopping/' do
  let(:theStore) { Store::Store.new }
  let(:gui) { Terminal::TerminalPos.new }

  #  describe '#Startup-initialization' do
      it 'Says Hello to the (Admin) user upon instantiation.' do
        expect { Terminal::TerminalPos.new() }.to match_stdout( "Hello from your POS") #" Terminal Controller!")
      end

      it 'Does Not accept a redefined $stdin nor $stdout.' do
        expect{Terminal::TerminalPos.new($stdin)}.to  raise_error ArgumentError
      end

      context 'Read/Write from System IO.' do

        it "#prompt_confirm: Causes the user to verify another product should be entered." do
          gui.stub(:gets) {"stubbed-y"}
          expect {gui.prompt_confirm}.to match_stdout("confirm to continue")
        end

        it "#prompt_for_product: Allows entry of a single product's pricelist as verified by 'enter' prompt." do
          gui.stub(:gets) { "stubbed-typing\n" }
          expect { gui.prompt_for_product }.to match_stdout("enter the")
          expect(gui).to have_received( :gets).exactly(4).times

          # example;
          # stdout [Please enter the id.
          #got value=stubbed-typing
          #Please enter the price.
          #                     got value=stubbed-typing
          #Please enter the batchPrice.
          #                     got value=stubbed-typing
          #Please enter the numberForBatchDiscount.
          #                     got value=stubbed-typing
          #]
        end
      end


  context 'TBA' do
      it 'allows entry of product-id, price'

      it 'allows entry of product-id, price, qualifying quantity, and discounted price'

      it 'verifies item added to a cart is in the store.' do
        pending '(first dependency)'
      end

      it 'allows less-strict entry of products, eg defaults.'
        # http://stackoverflow.com/questions/7534905/how-can-i-fix-this-ruby-yes-no-style-loop

      it 'FUTURE KATA: Redesign to be responsibility-based, not object-based.'
    # http://blog.rubybestpractices.com/posts/gregory/037-issue-8-uses-for-modules.html

    it 'FUTURE: Allow Unix-style redirect of Stdio.'
    # One example in init used;
    #     @input = $stdin
    #  @output = $stdout


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