module Terminal
  class TerminalPos
  def initialize ()
    @input = $stdin
    @output = $stdout
    @output.print('Hello from your POS Terminal Controller!')
  end

  def start(prices)
    @prices = prices
    @outs+['hi']
    #@outs.puts( "hi")
  end
  end
end