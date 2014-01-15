require 'rspec'
require 'logger'
require './specLib/custom_stdout_matcher'

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
end #end array

describe '#Ruby HashMap' do
  it 'An Array of Maps can be printed using each array element index and each map key.' do
    i_index = 0
    print(i_index)
    #ary = [{:id=>"a", :price=>100, :numberForBatchDiscount=>0, :batchPrice=>0},{:id=>"b", :price=>200, :numberForBatchDiscount=>2, :batchPrice=>20}]
    ary1 = [{:id=>"a", :price=>100, :numberForBatchDiscount=>0, :batchPrice=>0}]
    ans=ary1[i_index]
    print(ans.to_s)
    expect(ans.to_s).to eq("{:id=>\"a\", :price=>100, :numberForBatchDiscount=>0, :batchPrice=>0}")
    expect(ary1[i_index][:id]).to eq("a")
    expect(ary1[i_index][:price]).to eq(100) #Number
  end

  it 'Find_All on a list of maps responds with a list.' do
    pending 'refactor this prior code to make nice examples'
    #def price_non_discounted (aProduct)
      #Ruby-TIP: Find_all on a list does NOT unpack, result is still a list because may be many hits.
      answerListOfMaps = products.find_all { |i|
        i[:id] == aProduct  }
      raise "Invalid Product ID." if answerListOfMaps.equal?(nil) || answerListOfMaps.empty?
      return answerListOfMaps[0][:price]
      #answer = nil
      ##print (@products)
      #i_index = 0
      #  products.each { |i|
      #    print (['loop=',i_index,' item=',
      #          @products[i_index], ' id=',
      #          @products[i_index][:id], ' price=',
      #          @products[i_index][:price], ' =eol= ',
      #          ' comparing to ', aProduct])
      #    answer = @products[i_index][:price] if (@products[i_index][:id].equal?(aProduct))
      #    i_index = i_index+1
      #  }
      #  print[' =answer=', answer.to_s]

  end
end

describe 'zRuby/Printing and Logging-Tips/' do
  it 'Can Print  File.dirname(__FILE__) which is this very folder.' do
    # http://stackoverflow.com/questions/16147846/referencing-file-location-in-rspec-rake-task-vs-rspec-runner
    # http://stackoverflow.com/questions/19106165/how-do-i-run-unix-commands-using-system-and-backticks
    ans = Dir.pwd + "/specFut"#('C:/amsrc/rmtry/specFut')
    print(ans)
    expect(  File.dirname(__FILE__).to_s).to eq(ans.to_s)
  end

  it 'Prints nice nil arrays, but ensure to use array of items, not plus (+).' do
    # http://stackoverflow.com/questions/5018633/what-is-the-difference-between-print-and-puts
    a = 1.01
    b = (a * 100).round
    expect{print(["in=", a.to_s, " out=", b.to_s])}.to match_stdout('')
  end

  it 'Logs most quietly with Debug, then Info, Warn, Error, Fatal.' do
    $LOG = Logger.new($stderr)
    $LOG.level = Logger::DEBUG
    $LOG.debug('initialize= '+@thegifts.to_s+' //Logging Test.')
    expect(0).to eq(0)
  end

  it 'Has Case/Switch statement with When/Else clauses, eg for printing.' do
      a='hi'
      case a
        when  'hi'
          expect(true).to eq(true)
        when 1..5
        else
      end
  end
end

describe 'zRuby/Error-Handling-Tips/' do
  it 'Throws NoMethodError with an unknown method.' do
    expect{[0,1].y()}.to raise_error NoMethodError
  end

  it 'Throws NameError with an unknown class.' do
    expect{aaa.to_s}.to raise_error NameError
  end

  it "With Only Describe, No It clause, Throws syntax error= NoMethodError: undefined method `expect' for #<Class"
    # http://stackoverflow.com/questions/11369798/following-rspec-exception-handling-getting-nomethoderror-for-expect

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