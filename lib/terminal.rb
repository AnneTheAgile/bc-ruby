module Terminal
  # A Shopping experience is made available through the simple Command-line User interface (CLI) implemented by TerminalPos.
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