# C:\amsrc\rmtry\lib\terminal.rb
require './lib/cart'
require './lib/store'

module Terminal

  # A Point of Sale (POS) Terminal, aka a Cash Register, that provides the ability for an Admin to create a shop of products and a Buyer to choose items for purchas. Both an API and a simple Command-line User interface (CLI) are available. (A View)
  class Terminal

    attr_reader :store, :cart, :total
    attr_accessor :live # Ruby-tip; Explicit test is better than testing  $stdout.isatty ISSUE#02

    def initialize (aStore, aLive=false)
      raise "Error, Argument is not a Store, it is  #{aStore.class.to_s}."   if aStore.class != Store::Store
      @store = aStore
      @cart = Cart::Cart.new(@store)
      @live = aLive
      print("Hello from your POS Terminal Controller! Value of Running-Live=#{aLive}\n") if @live==true
    end

    # Prompt for all data and report the receipt total. (Called when run this file rather than use its API.)
    def runInteractive
      prompt_loop_for_products
      prompt_loop_for_cart
      print(["\nThank you for your purchases! Your total is: ",total,"\n"].join)
    end

    def setPricing(aArrayOfProductInfoArrays)
      aArrayOfProductInfoArrays.each{|iProduct|
        case iProduct.length
          when 0,3
            raise "Each product entry item must have either two or four aguments (ItemId, Price, MinimumBatchQuantity, BatchPrice). Problem for: #{iProduct.to_s}"   if ((iProduct.length==3)||(iProduct.length>4))
          when 2
            @store.add_product(iProduct[0],iProduct[1],0,0) if iProduct.length == 2
          when 4
            @store.add_product(iProduct[0],iProduct[1],iProduct[2],iProduct[3]) if (iProduct.length == 4)
        end
      }
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

    # Provide the overhead functionality for prompting and yield to the given block for specific prompt.
    # (ISSUE#03) Note; It would be preferable to delay the presentation of the object's printing,
    # as done previously, but one cannot pass two different yield blocks, so now clients are responsible for printing verification messages.
    def prompt_loop_customized(aHiString, aByeString)
      print("\nWelcome to #{aHiString}. \n ")
      while prompt_confirm
        ans = yield
      end
      print (["Thank you for #{aByeString}.\n"].join)
    end

    def prompt_loop_for_products()
      aHi = "the Admin Process of entering the Store's Products and their Prices"
      aBye ="entering the Store's Price list"
      prompt_loop_customized(  aHi, aBye) { |i|
        prompt_for_product
        print(["...So far your product is;",@store.report," #{i.to_s} \n",].join)
      }
    end

    def prompt_loop_for_cart()
      aHi = "the Customer Process of entering a list of Products to put in the Cart for purchase.\n" +
          "  1.In between each entry, you will be given a chance to stop. \n"
      aBye ="entering your Cart list"
      prompt_loop_customized(  aHi, aBye) { |i|
        prompt_for_cart_item
        print(["...So far your Cart is;",@cart.report," #{i.to_s} \n",].join)
      }
    end

    # 1.Ask the user to enter all the data for a single product - No defaults allowed - Secret zero value for last two items; 2.Add it to the store.
    def prompt_for_product()
      print("Please enter this product's details.\n" +
          "  1.For NumberForBatchDiscount and BatchPrice, zero may be used to indicate no discounts are available.\n")
      map = {}
      keys = (Store::Store.new).product_attributes
      keys.each { |ithKey|
        print(["Please enter the ",ithKey,".\n"].join)
        ithValue = gets.chomp #Outputs a String without the \n
        map[ithKey] = ithValue
      }
      @store.add_product_map(map)
      map
    end

    # 1.Ask the user to enter a Product code; 2.Add it to the cart.
    def prompt_for_cart_item()
      print(["Please enter a ","Product ID to add to your shopping cart.","\n"].join)
      aProduct = gets.chomp
      @cart.add(aProduct)
      aProduct
    end

    def scan(aId)
      @cart.add(aId)
    end

    def report
      @cart.report_total
    end

    def total
      report
    end

  end

  # Start from project root directory.
  if __FILE__ == $0
    x = Terminal.new(Store::Store.new,true) #No ARGV
    x.runInteractive
  end
end