require 'rspec' # core, expectations, mocks, support
require './lib/terminal'
require './lib/store'
require './lib/cart'

describe 'Terminal/Shopping/' do
  let(:gui) {Terminal::TerminalPos.new($stdin, $stdout) }
  let(:theStore) { Store::Store.new }
  let(:aCart) { Cart::Cart.new }

  #  describe '#Startup-initialization' do

      it 'requires $stdin and $stdout or an appropriate interface (no type checking).' do
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
