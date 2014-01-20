require 'rspec'
require 'logger'
require './spec/lib/custom_stdout_matcher'
# Rspec-tip; v3; no need to require mocks sub-module separately, nor to insert mocks into a type.
#require 'rspec/mocks' #Name is rspec-mocks
#RSpec::Mocks::setup(Mirror.new)

# rspec-tip; Notice that configure is setting the rspec-mocks syntax, not the rspec-expectations syntax
# http://stackoverflow.com/questions/20275510/how-to-avoid-deprecation-warning-for-stub-chain-in-rspec-3-0
RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

class Mirror
  def prompt_and_echo
    print "Please enter something: "
    # Do not chain gets.chomp so that can test more easily.
    response = gets
    response = fixup(response)
    puts "#{response}"
    response
  end

  def fixup(aString)
    aString.chomp
  end
end

describe 'Read/Write from System IO - via regular stub.' do

  it '#prompt_and_echo: Receives entered text with Gets.' do
    @mirror = Mirror.new
    @mirror.stub(:gets).and_return( "stubbed-\n" )

    answer = @mirror.prompt_and_echo
    expect(answer).to eq("stubbed-")
    expect(@mirror).to have_received( :gets  )
  end

  it '#prompt_and_echo: Prompts to enter text with Print.' do
    @mirror = Mirror.new
    @mirror.stub(:gets) { "stubbed-for-chomp-and-permissions\n" } #Collaborator
    @mirror.stub(:print)  #stubbed-for-expect
    #@mirror.stub(:puts)  #stubbed-for-nil
    answer = @mirror.prompt_and_echo
    expect(@mirror).to have_received( :print ).with(/enter/)
  end

  it '#prompt_and_echo: Writes Echo of received text with Puts.' do
    @mirror = Mirror.new
    @mirror.stub(:gets) { "stubbed-typing\n" } #Collaborator
    @mirror.stub(:puts)
    @mirror.prompt_and_echo
    expect(@mirror).to have_received( :puts ).with("stubbed-typing")
  end

  it '#prompt_and_echo: Writes Echo for text - via Allows.' do
    pending 'When get time, refactor per additional syntax.'
    # new way;
    # http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    # d = double(:message1 => true)
    # allow(d).to receive(:message2).and_return(:value)
    # allow(real_object).to receive(:message).and_return(:value)
  end

  # Answering the prompt is not actually required.
  #expect { gui.prompt_for_product }.to match_stdout("enter x to stop")

  # http://stackoverflow.com/questions/4609872/rspec-commandline-variable-input
  def ask(aFcn) #helper
    # []TODO confirm yield not more appropriate
    (Terminal::Terminal.new).aFcn
  end

end