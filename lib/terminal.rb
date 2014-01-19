# C:\amsrc\rmtry\lib\terminal.rb
require './lib/cart'
require './lib/store'

module Terminal

  # A Shopping experience is made available through the simple Command-line User interface (CLI) implemented by TerminalPos.
  class TerminalPos

    def initialize (aStore)
      raise "Error, Argument is not a Store, it is  #{aStore.class.to_s}."   if aStore.class != Store::Store
      @store = aStore
      @cart = Cart::Cart.new(@store)
      print("Hello from your POS Terminal Controller!\n")
    end

    def prompt_confirm()
      print("Please confirm to continue with 'y' for yes.\n")
      doAnother = gets.chomp
      if (doAnother=='y')
        return true
      else
        return false
      end
    end

    def prompt_loop__for_products()
      print("Welcome to the Admin Process of entering products and their prices. \n ")

      list=[]
      while prompt_confirm
        ans = prompt_for_product
        list << ans
        print(["\n",'got ans=',ans.to_s,"\n"])
  #      print(["\n",'got ans, id=',ans[:id]," price=",ans[:price],"\n"])
   #     print(["\n","and list=\n",list.to_s,"\n"])
      end

      print (["Thank you for entering the price list. It is; \n",list.to_s,"\n"])
    end

    # Ask the user to enter all the data for a single product - No defaults allowed - Secret zero value for last two items.
    def prompt_for_product()
      map = {}
      keys = (Store::Store.new).product_attributes
      keys.each { |ithKey|
        print(["Please enter the ",ithKey,".\n"].join)
        ithValue = gets.chomp
        print(["got value=",ithValue,"\n"].join)
        map[ithKey] = ithValue
      }
      map
    end

  end
end