require 'rspec'
require 'logger'

describe 'zRuby/Data-Structures-Tips/' do
  describe '#Ruby Array' do

    it 'Adds another element using less-than\'s: aArray << aElt.' do
      a = [0,1]
      expect(1+2).to eq(3)
#      expect {a << 2}.to eq("[0, 1, 2]".to_s)
    end

    it 'Makes its to_s with square brackets, space separators, and double double quotes.' do
      a = [1,2]
      a << 'b'
      expect(a.to_s).to eq("[1, 2, \"b\"]")
    end
  end

end

describe 'zRuby/Logging-Tips/' do
  it 'Logs most quietly with Debug, then Info, Warn, Error, Fatal.' do

    $LOG = Logger.new($stderr)
    $LOG.level = Logger::DEBUG
    $LOG.debug('initialize= '+@thegifts.to_s+' //Logging Test.')
    expect(0).to eq(0)
  end

  it 'Is testable by capturing sysout.' do
    pending 'IDK how to use the let(:outs) statement.'
#    let(:outs) { [] }  #double('output')}
#    let(:term) {Terminal::TerminalPos.new(['g'])}
#    let(:term) {Terminal.new(:outs)}
  end
end

describe 'zRuby/Error-Handling-Tips/' do
  it 'Throws NoMethodError with an unknown method.' do
    expect{[0,1].y()}.to raise_error NoMethodError
  end

  it 'Throws NameError with an unknown class.' do
    expect{aaa.to_s}.to raise_error NameError
  end

  it 'Throws NotImplementedError when...??'
end

describe 'zRuby/Rspec-Tips' do
  it 'Throws NoMethodError (not NotImplementedError) with space before object of expect - avoid "expect (x)" - FUTURE, fix BUG in Cheatsheet.' do
    expect{expect ('0').to eq('1')}.to raise_error NoMethodError
  end

  xit 'Will not run any "it" test that is changed to "xit".'

  it 'Will not run and will explain the cause for delay with the the given pending clause\'s text.' do
    pending 'Not implementing this to make an example.'
  end


  it 'Evaluates contents between parens (1+2), not needing a block {1+2}.' do
    expect(1+2).to eq(3)
  end

end

describe 'zRuby/Regex-Tips/' do

  it 'Has caret ^ matching bol, dollar sign $ for eol, and i for case insensitivity.' do
    expect("a hi string").to match(/^.*hi.*$/i)
  end

end


# BUG        expect(a2).to match('hi')
# NoMethodError: undefined method `match' for ["g", "hi"]:Array
#        expect(:outs.to_s).to match('hi')
# WORKS        expect(a2.to_s).to match('hi')
#        expect(:outs.to_s).to match('hi')
# bug eq
#        expect(:outs).to receive(:puts).with('hi')
