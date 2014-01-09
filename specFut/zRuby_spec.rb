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

describe 'zRuby/Printing and Logging-Tips/' do
  it 'Prints nice nil arrays, but ensure to use array of items, not plus (+).' do
    # http://stackoverflow.com/questions/5018633/what-is-the-difference-between-print-and-puts
    a = 1.01
    b =                     (a * 100).round
    expect {print ["in=", a.to_s, " out=",    b.to_s   ] }.to eq('')

  end

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


# []RQ why can't make x=Hash.new(a,1)?
# []TRY match_array