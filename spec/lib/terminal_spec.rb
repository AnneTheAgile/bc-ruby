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
    Terminal::Terminal.new(theStore)
  end

  describe 'API Access allows simple manipulations.' do

    it "#SetPricing: Enables Admin to enter a set of products and their prices." do
      g = theGui
      g.setPricing([['a',1],['b',20,2,10],['c',3,3,2]])
      expect(g.store.report).to eq("[{:id=>\"a\", :price=>1.0, :numberForBatchDiscount=>0, :batchPrice=>0.0}, {:id=>\"b\", :price=>20.0, :numberForBatchDiscount=>2, :batchPrice=>10.0}, {:id=>\"c\", :price=>3.0, :numberForBatchDiscount=>3, :batchPrice=>2.0}]")
    end

    it '#Scan will add items to the cart.' do
      g = theGui
      g.setPricing([['a',1],['b',20,2,10],['c',3,3,2]])
      g.scan('a')
      g.scan('c')
      expect(g.cart.report).to eq("[\"a\", \"c\"]")
    end

    it '#Total provides the bill, without itemization.' do
      g = theGui
      g.setPricing([['a',1],['b',20,2,10],['c',3,3,2]])
      g.scan('a')
      g.scan('c')
      expect(g.total).to eq("$4.00")
    end

  end

  describe 'Admin can Initialize the Store with a CLI.' do

    it '#Initialize Raises error if fail to provide a Store to the constructor.' do
      expect{Terminal::Terminal.new}.to raise_error ArgumentError
    end

    it '#Initialize Requires a Store.' do
      expect{Terminal::Terminal.new($stdin)}.to  raise_error(RuntimeError, /Argument is not a Store./)
    end

    it '#Initialize Says Hello to the (Admin) user upon instantiation.' do
      expect { theGui }.to match_stdout( "Hello from your POS") #" Terminal Controller!")
    end

  end

  describe 'Admin can Add Products to the store through the CLI - Read/Write of System IO.' do

    it "#Prompt_confirm: Causes the user to verify another product should be entered." do
      g = theGui
      g.stub(:gets) {"stubbed-y"}
      expect {g.prompt_confirm}.to match_stdout("confirm to continue")
    end

    it "#Prompt_for_product: Allows entry of a single product's pricelist ( product-id, price, qualifying quantity, and discounted price) as verified by the prompt and the store's pricelist." do
      g = theGui
      g.stub(:gets).and_return("aId\n","5\n","6\n","7\n")
      expect { g.prompt_for_product }.to match_stdout("enter the")
      expect(g).to have_received( :gets).exactly(4).times
      expect(g.store.report).to eq("[{:id=>\"aId\", :price=>5.0, :numberForBatchDiscount=>\"7\", :batchPrice=>6.0}]")
    end

    it "#Prompt_loop__for_products Allows entry of two Products' data." do
      g = theGui
      g.stub(:gets).and_return("y","aId\n","5\n","6\n","7\n","y","bId\n","5\n","6\n","7\n","no-halt")
      expect { g.prompt_loop__for_products }.to match_stdout("enter the")
      expect(g).to have_received( :gets).exactly(11).times
      expect(g.store.report).to eq("[{:id=>\"aId\", :price=>5.0, :numberForBatchDiscount=>\"7\", :batchPrice=>6.0}, {:id=>\"bId\", :price=>5.0, :numberForBatchDiscount=>\"7\", :batchPrice=>6.0}]")
    end

  end


  describe 'User can Add to a Cart and Get Totals with through the CLI with System IO.' do

    it "#Prompt_for_cart_item: Accepts entry of a single Product ID." do
      g = theGui
      g.store.add_product('aId',5,6,7)
      g.stub(:gets).and_return("aId\n","5\n","6\n","7\n")
      expect { g.prompt_for_cart_item }.to match_stdout("enter the")
      expect(g).to have_received( :gets).exactly(1).times
      expect(g.cart.report).to eq("[\"aId\"]")
    end

    it "#Prompt_loop_for_cart Allows entry of any desired products to purchase." do
      g = theGui
      g.store.add_product('aId',5,6,7)
      g.store.add_product('bId',8,9,10)
      g.stub(:gets).and_return("y","aId\n","y","bId\n","no-halt")
      expect { g.prompt_loop_for_cart }.to match_stdout("enter the")
      expect(g).to have_received( :gets).exactly(5).times
      expect(g.cart.report).to eq("[\"aId\", \"bId\"]")
    end

  end


  describe 'TBA - requirements not completed yet.' do

    it "Refactor, Consolidate to single prompt_loop with yield."
    # http://stackoverflow.com/questions/10451060/use-of-yield-and-return-in-ruby

=begin
    def prompt_loop(aPrompt, aReportFunction, aHiMsg, aByeMsg)
      print("Welcome to the #{aHiMsg}. \n ")
      while prompt_confirm
        ans = prompt_for_cart_item
        #print(["\n",'got ans=',ans.to_s,"\n"])
      end
      print (["Thank you for entering #{aByeMsg}. It is; \n",@cart.report,"\n"])
    end
=end

  end

  describe 'FUTURE possible work.' do

    it "During entry of product's price, display a convenient message that Zero (0) is the Default value for quantity and price."

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
