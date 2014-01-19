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

describe 'Terminal' do
  def theStore
    Store::Store.new
  end

  def theGui
    Terminal::TerminalPos.new(theStore)
  end

  describe 'Requires Initialization and Setup.' do

    it '#Initialize Raises error if fail to provide a Store to the constructor.' do
      expect{Terminal::TerminalPos.new}.to raise_error ArgumentError
    end

    it '#Initialize Requires a Store.' do
      expect{Terminal::TerminalPos.new($stdin)}.to  raise_error(RuntimeError, /Argument is not a Store./)
    end

    it '#Initialize Says Hello to the (Admin) user upon instantiation.' do
      expect { theGui }.to match_stdout( "Hello from your POS") #" Terminal Controller!")
    end

  end

  describe 'Can Start and Read/Write from System IO.' do

      it "#Prompt_confirm: Causes the user to verify another product should be entered." do
        g = theGui
        g.stub(:gets) {"stubbed-y"}
        expect {g.prompt_confirm}.to match_stdout("confirm to continue")
      end

      it "#Prompt_for_product: Allows entry of a single product's pricelist ( product-id, price, qualifying quantity, and discounted price) as verified by the prompt occurring four times." do
        g = theGui
        g.stub(:gets) { "stubbed-typing\n" }
        expect { g.prompt_for_product }.to match_stdout("enter the")
        expect(g).to have_received( :gets).exactly(4).times
      end

    end


  describe 'TBA - requirements not completed yet.' do

    it 'Allows entry of product-id, price, defaulting for quantity and price'

    it 'Verifies any item added to a cart is in the store.' do
      pending '(first dependency)'
    end

  end


  describe 'FUTURE possible work.' do

    it 'Allows less-strict entry of products, eg defaults.'
      # http://stackoverflow.com/questions/7534905/how-can-i-fix-this-ruby-yes-no-style-loop

    it 'Rector, KATA: Redesign to be responsibility-based, not object-based.'
  # http://blog.rubybestpractices.com/posts/gregory/037-issue-8-uses-for-modules.html

    it 'Enables tests to be silent so $sysout from prompting does not clutter the Rspec output.'

    it 'Allows Unix-style redirect of Standard IO, stdin/stdout.'
    # One example in init used;
    #     @input = $stdin
    #  @output = $stdout

    it "#prompt_for_product: Specifically includes four prompts. (Add test to prove this.)"
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

    it 'Refactor; Use Rspec Let to construct a complex, nested object instead of Method calls.' do
      pending "Grok Rspec's Let vs Subject vs Method call prep."
      expect('a').to be_kind_of(String)
      expect(Store::Store.new).to be_kind_of(Store::Store)
      expect(theStore).to be_kind_of(Store::Store)
      #let(:theStore) { Store::Store.new }
      #let(:gui) { Terminal::TerminalPos.new(@theStore) }
      #expect{Terminal::TerminalPos.new(Store::Store.new)}.not_to  raise_error

      #and;
      # fail; NilClass not store;  Terminal::TerminalPos.new(@theStore)
      # fail no match; @gui
      #expect { Terminal::TerminalPos.new(Store::Store.new) }.to match_stdout( "Hello from your POS") #" Terminal Controller!")

    end

  end

end
