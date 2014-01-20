# C:\amsrc\rmtry\lib\terminal.rb
require './lib/cart'
require './lib/store'

module Terminal

  # A Point of Sale (POS) Terminal, aka a Cash Register, provides the ability for an Admin to create a shop of products and a Buyer to choose items for purchase. Both an API and a simple Command-line User interface (CLI) are available.
  class Terminal

    attr_reader :store, :cart, :total

    def initialize (aStore)
      raise "Error, Argument is not a Store, it is  #{aStore.class.to_s}."   if aStore.class != Store::Store
      @store = aStore
      @cart = Cart::Cart.new(@store)
      print("Hello from your POS Terminal Controller!\n") if $stdout.isatty
    end

    def runInteractive
      prompt_loop__for_products
      prompt_loop_for_cart
      print(["\nThank you for your purchases! Your total is: ",total,"\n"].join)
    end

    def setPricing(aArrayOfProductInfoArrays)
      aArrayOfProductInfoArrays.each{|iProduct|
        raise "Each product entry item must have either two or four aguments (ItemId, Price, MinimumBatchQuantity, BatchPrice). Problem for: #{iProduct.to_s}"   if ((iProduct.length==3)||(iProduct.length>4))
        @store.add_product(iProduct[0],iProduct[1],0,0) if iProduct.length == 2
        @store.add_product(iProduct[0],iProduct[1],iProduct[2],iProduct[3]) if (iProduct.length == 4)
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

    def prompt_loop__for_products()
      print("\nWelcome to the Admin Process of entering the Store's Products and their Prices. \n ")
      while prompt_confirm
        ans = prompt_for_product
      end
      print (["Thank you for entering the Store's Price list. It is; \n",@store.report,"\n"].join)
    end

    def prompt_loop_for_cart()
      print("\nWelcome to the Customer Process of entering a list of Products to put in the Cart for purchase.\n" +
      "  1.In between each entry, you will be given a chance to stop. \n" +
      "  2.For NumerForBatchDiscount and BatchPrice, zero may be used to indicate no discounts are available.\n")
      while prompt_confirm
        ans = prompt_for_cart_item
      end
      print (["Thank you for entering your Cart list. It is; \n",@cart.report,"\n"].join)
    end

    # 1.Ask the user to enter all the data for a single product - No defaults allowed - Secret zero value for last two items; 2.Add it to the store.
    def prompt_for_product()
      print("Please enter this product's details.\n")
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
    x = Terminal.new(Store::Store.new) #No ARGV
    x.runInteractive
  end
end