module Terminal
  class TerminalPos
  def initialize (aInStream, aOutStream)
    @input = aInStream
    @output = aOutStream
    @output.puts('hi from your POS Termina Controller!\n')
  end

  def start(prices)
    @prices = prices
    @outs+['hi']
    #@outs.puts( "hi")
  end
  end
end