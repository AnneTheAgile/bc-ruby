module Terminal

  class TerminalPos
  def initialize (aOutStream)
    @outs = aOutStream
  end

  def start(prices)
    @prices = prices
    @outs+['hi']
    #@outs.puts( "hi")
  end
  end
end