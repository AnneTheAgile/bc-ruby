require 'rspec' # core, expectations, mocks, support
require './lib/terminal'

#  require 'C:\Users\amoroney\amPrjs\rmtry\lib\terminal.rb'   #'terminal'

describe 'Shopping' do
    let(:outs) { [] }  #double('output')}
    let(:term) {Terminal::TerminalPos.new(['g'])}
#    let(:term) {Terminal.new(:outs)}

    describe '#Startup-initialization' do
      xit 'asks for product pricelist.'

      it 'shows temporarily hard-coded contents: [g, hi], in quotes.' do
        a2 =term.start(nil)
        expect(a2.to_s).to match(/^.*hi.*$/i) # "[\"g\", \"hi\"]"
      end
    end

  end

describe 'Ruby-TIP' do

  describe '#Ruby Array' do
    it 'prints with its square brackets, spacing, and double quotes.' do
      a = [1,2]
      a << 'b'
      expect(a.to_s).to eq("[1, 2, \"b\"]")
    end
  end

end

# BUG        expect(a2).to match('hi')
        # NoMethodError: undefined method `match' for ["g", "hi"]:Array
#        expect(:outs.to_s).to match('hi')
# WORKS        expect(a2.to_s).to match('hi')
#        expect(:outs.to_s).to match('hi')
        # bug eq
#        expect(:outs).to receive(:puts).with('hi')
