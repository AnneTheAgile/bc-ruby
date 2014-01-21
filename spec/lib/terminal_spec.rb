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

  def theGui(aStdProductList=false, aLive=false)
    g = Terminal::Terminal.new(theStore,aLive)
    # Standard Store has these products and values.
    g.setPricing([['A',2,4,7],['B',12],['C',1.25,6,6],['D',0.15]]) if aStdProductList==true
    g
  end

  describe 'Has Basic Housekeeping Metadata.' do

    it 'Code Review of RDoc API Documentation can pass.' do
      expect(File.exist?("./doc/index.html")).to eq(true)
    end

  end


  describe 'Has API Access.' do

    it "#SetPricing: Enables Admin to enter a set of products and their prices." do
      g = theGui
      g.setPricing([['a',1],['b',20,2,10],['c',3,3,2]])
      expect(g.store.report).to eq("[{:id=>\"a\", :price=>1.0, :numberForBatchDiscount=>0, :batchPrice=>0.0}, {:id=>\"b\", :price=>20.0, :numberForBatchDiscount=>2, :batchPrice=>10.0}, {:id=>\"c\", :price=>3.0, :numberForBatchDiscount=>3, :batchPrice=>2.0}]")
    end

    it "#SetPricing: Sample Test: Can enter A=2/1, 4/7; B=12; C=1.25/1, 6/6; D=0.15." do
      g = theGui(true)
      expect(g.store.report).to eq("[{:id=>\"A\", :price=>2.0, :numberForBatchDiscount=>4, :batchPrice=>7.0}, {:id=>\"B\", :price=>12.0, :numberForBatchDiscount=>0, :batchPrice=>0.0}, {:id=>\"C\", :price=>1.25, :numberForBatchDiscount=>6, :batchPrice=>6.0}, {:id=>\"D\", :price=>0.15, :numberForBatchDiscount=>0, :batchPrice=>0.0}]")
    end

    it "#Scan will add items to the cart." do
      g = theGui
      g.setPricing([['a',1],['b',20,2,10],['c',3,3,2]])
      g.scan('a')
      g.scan('c')
      expect(g.cart.report).to eq("[\"a\", \"c\"]")
    end

    it "#Total provides the bill, without itemization." do
      g = theGui
      g.setPricing([['a',1],['b',20,2,10],['c',3,3,2]])
      g.scan('a')
      g.scan('c')
      expect(g.total).to eq("$4.00")
    end

    it '#Total: Sample Test#1: Cart of ABCDABAA should be $32.40.' do
      g = theGui(true)
      g.scan('A')
      g.scan('B')
      g.scan('C')
      g.scan('D')
      g.scan('A')
      g.scan('B')
      g.scan('A')
      g.scan('A')
      expect(g.total).to eq("$32.40")
    end

    it '#Total: Sample Test#2: Cart of CCCCCCC should be $7.25.' do
      g = theGui(true)
      g.scan('C')
      g.scan('C')
      g.scan('C')
      g.scan('C')
      g.scan('C')
      g.scan('C')
      g.scan('C')
      expect(g.total).to eq("$7.25")
    end

    it '#Total: Sample Test#3: Cart of ABCD should be $15.40.' do
      g = theGui(true)
      g.scan('A')
      g.scan('B')
      g.scan('C')
      g.scan('D')
      expect(g.total).to eq("$15.40")
    end

    it '#Total: Sample Test#4: Cart of A should be $2.00.' do
      g = theGui(true)
      g.scan('A')
      expect(g.total).to eq("$2.00")
    end

  end

  describe 'Admin can Initialize the Storein a CLI, ie Read/Write of System IO.' do

    it '#Initialize Raises error if fail to provide a Store to the constructor.' do
      expect{Terminal::Terminal.new}.to raise_error ArgumentError
    end

    it '#Initialize Requires a Store.' do
      expect{Terminal::Terminal.new($stdin)}.to  raise_error(RuntimeError, /Argument is not a Store./)
    end

    it '#Initialize Says Hello to the (Admin) user upon instantiation only if running Live/Interactively.(ISSUE#02)' do
      expect { theGui(false,true) }.to match_stdout( "Hello from your POS")
      expect { theGui(false,false) }.not_to match_stdout( "Hello from your POS")
    end

  end

  describe 'Admin can Add Products to the store in a CLI, ie Read/Write of System IO.' do

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
      expect(g.store.report).to eq("[{:id=>\"aId\", :price=>5.0, :numberForBatchDiscount=>6, :batchPrice=>7.0}]")
    end

    it "#Prompt_loop_for_products Allows entry of Two Products' data." do
      g = theGui
      g.stub(:gets).and_return("y","aId\n","5\n","6\n","7\n","y","bId\n","5\n","6\n","7\n","no-halt")
      expect { g.prompt_loop_for_products }.to match_stdout("enter the")
      expect(g).to have_received( :gets).exactly(11).times
      expect(g.store.report).to eq("[{:id=>\"aId\", :price=>5.0, :numberForBatchDiscount=>6, :batchPrice=>7.0}, {:id=>\"bId\", :price=>5.0, :numberForBatchDiscount=>6, :batchPrice=>7.0}]")
    end

    it "#Prompt_loop_for_products Displays a message that Zero (0) is the Default value for Batch quantity and price." do
      g = theGui
      # Without Mock, Ruby Rspec Errno::EACCES: Permission denied -
      # Without at least one 'yes', do not see the tickler.
      g.stub(:gets).and_return("y","aId\n","5\n","6\n","7\n","no-halt")
      expect { g.prompt_loop_for_products }.to match_stdout("zero may be used")
    end

  end


  describe 'User can Add to a Cart and Get Totals in a CLI, ie Read/Write of System IO.' do

    it "#Prompt_for_cart_item: Accepts entry of a single Product ID." do
      g = theGui
      g.store.add_product('aId',5,6,7)
      g.stub(:gets).and_return("aId\n","5\n","6\n","7\n")
      expect { g.prompt_for_cart_item }.to match_stdout("enter a")
      expect(g).to have_received( :gets).exactly(1).times
      expect(g.cart.report).to eq("[\"aId\"]")
    end

    it "#Prompt_loop_for_cart Allows entry of any desired products to purchase." do
      g = theGui
      g.store.add_product('aId',5,6,7)
      g.store.add_product('bId',8,9,10)
      g.stub(:gets).and_return("y","aId\n","y","bId\n","no-halt")
      expect { g.prompt_loop_for_cart }.to match_stdout("enter a")
      expect(g).to have_received( :gets).exactly(5).times
      expect(g.cart.report).to eq("[\"aId\", \"bId\"]")
    end

  end


  describe 'TBA - requirements not completed yet.' do
    # No Functional requirements! 2014-01-19x

    it 'Code Review can pass Ruby Lint on both Windows/Mac.' do
      pending '[]Ask for advice on which Ruby Lint to use and/or what RubyMine highlighting rules (only fixed Red errors 2014-01-20).'
      # 1.This popular codebase runs only on nix?
      # https://github.com/YorickPeterse/ruby-lint
      # 2.Sublime editor may work, but RubyMine which I use may already be OK?
      # https://github.com/SublimeLinter/SublimeLinter
      # 2008+ http://stackoverflow.com/questions/1805146/where-can-i-find-an-actively-developed-lint-tool-for-ruby
    end

  end

  describe 'FUTURE possible work.' do

    describe 'FUTURE Houskeeping work' do

      it 'Add Help option, Consolidate prompts for CLI.'
      it 'Refactor so that Documentation strings for the CLI Prompts are not stored in Terminal but rather in the relevant objects, Cart and Store.'

      it "Refactor Tests because the Rspec Test fixtures for Terminal/CLI look clunky?"

      it 'Add VERSION.txt and uptick helper.' do
        pending '[]Find the Version helper on Github, was it only Python?'
        # Python setup.py hooks into Git and finds a Tag!
        # this is not what I found previously.
        # https://github.com/habnabit/vcversioner
      end

      it 'Upload to Github with Copyright (Name??), Kudos, Tix, Links to DOC on readme.md, etc, if OK.'

      it 'Refactor as KATA: Re-Architect to be responsibility-based, instead of object-based.'
      # http://blog.rubybestpractices.com/posts/gregory/037-issue-8-uses-for-modules.html

      it 'Use Logger gem but Enable it to gracefully fail if requirement is not met, thus silent on $sysout except as desired.'

    end

    describe 'FUTURE Code work.' do

      it 'Allow Unix-style redirect of Standard IO, stdin/stdout.'
      # One example in init used;
      #     @input = $stdin
      #  @output = $stdout

      it "#prompt_for_product: Gives four prompts. (A test that proves this might hinder refactoring?)"
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

      it 'Refactor; Use Rspec Let to construct Lazy-Loaded, complex, nested objects instead of using Method calls.' do
        pending "Grok Rspec's Let vs Subject vs Method call prep."
        #Problems using the items inside the 'Let' object?
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

end
