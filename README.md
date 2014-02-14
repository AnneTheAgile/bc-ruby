bc-ruby
=======

Try little programs, tests, algorithms with Ruby, a la a bootcamp (bc).
Demonstration / Kata code in Ruby 1.9, Rspec 3.0, Cross-platform Win/Mac.

RmTry (for RubyMine Try) is a simple MVC CLI app and API that enables entering a few bits of data and computing metrics.

Version History
---------------
See the [ChangeLog] for details. 

* 2014-02-13r v 1.05 : Putting on Github. Renamed from rmtry to bc-ruby.
* 2014-01-20m v 1.04 : First production-worthy release.
* 2014-01-19x v 1.03 : Sprint#1 items all completed.

[ChangeLog]: file:///C:/amsrc/rmtry/changelog.md "Details of version history and ticket log in project root folder."


Definitions
-----------
See the [API documentation] for descriptions of most items. 

The main objects are;
*    Cart::Cart = A place to collect pending purchases. (A Model)
*    Money::Money = A way to Convert and manipulate US currency money (USD), as either dollars, eg 1.57, or pennies, eg 157. (A Model)
*    Store::Store = The reference to each Product's Name (ID) and Price list data, based dollars using whole pennies. (A Controller)
*    Terminal::Terminal = A Point of Sale (POS) Terminal, aka a Cash Register, that provides the ability for an Admin to create a shop of products and a Buyer to choose items for purchas. Both an API and a simple Command-line User interface (CLI) are available. (A View)

[API documentation]: file:///C:/amsrc/rmtry/doc/index.html "RDoc API Documentation at ./doc"


Getting started
---------------

1.The goal of the app as of v.1.04 is to be able to enter two kinds of objects (product prices and cart items) and then get one metric (total price of items in the cart.)

2.Rspec tests demonstrate use of the API. To run the equivalent tests as below for the command line, see; 
.\lib\terminal_spec.rb 
"#SetPricing: Enables Admin to enter a set of products and their prices."
"#Scan will add items to the cart."
"#Total provides the bill, without itemization."

3.Run Rspec --format documentation 
To see the verbose complete list of tested items, recreate it; 
```ruby
$ rspec.bat --format documentation > rspec.txt
```
For convenience, a copy is included in [RSpec.txt], with the redundant PENDING items removed from the tail and a summary added (2014-01-20). All PENDING items on a released build are for FUTURE possible work, such as customer feature requests or internal maintenance.

[RSpec.txt]: file:///C:/amsrc/rmtry/rspec.txt "RSpec verbose listing."


Example Output
---------------

Here is a simple demonstration of using the command line version from Windows 8.1 using Ruby;
/ruby/RailsInstaller/Ruby1.9.3/bin/ruby.

```ruby
>ruby .\lib\terminal.rb
Hello from your POS Terminal Controller! Value of Running-Live=true

Welcome to the Admin Process of entering the Store's Products and their Prices.
 Please confirm to continue with 'y' for yes.
y
Please enter this product's details.
  1.For NumberForBatchDiscount and BatchPrice, zero may be used to indicate no discounts are available.
Please enter the id.
a
Please enter the price.
10
Please enter the numberForBatchDiscount.
2
Please enter the batchPrice.
5
...So far your product is;[{:id=>"a", :price=>10.0, :numberForBatchDiscount=>2, :batchPrice=>5.0}]
Please confirm to continue with 'y' for yes.
n
Thank you for entering the Store's Price list.

Welcome to the Customer Process of entering a list of Products to put in the Cart for purchase.
  1.In between each entry, you will be given a chance to stop.
.
 Please confirm to continue with 'y' for yes.
y
Please enter a Product ID to add to your shopping cart.
a
...So far your Cart is;["a"]
Please confirm to continue with 'y' for yes.
y
Please enter a Product ID to add to your shopping cart.
a
...So far your Cart is;["a", "a"]
Please confirm to continue with 'y' for yes.
y
Please enter a Product ID to add to your shopping cart.
a
...So far your Cart is;["a", "a", "a"]
Please confirm to continue with 'y' for yes.
n
Thank you for entering your Cart list.

Thank you for your purchases! Your total is: $15.00

C:\amsrc\rmtry>
```


Infrastructure, Compatibility, and Credits
------------------------------------------

## An RSpec Test Coverage report is available at ; 
file:///C:/amsrc/rmtry/coverage/index.html


## Ruby version compatibility

* Only Ruby 1.9+ ships with the coverage library that SimpleCov depends upon. 
* Beware that Mac Boxen plus separate installs may not play nice.
* Windows Rails Installer worked well, but I am unsure how any additionally installed gems interoperate with Windows Installer integrity.

## Love and Kind Regards

Thanks to everyone at the NYC Ruby/Python/Haskell Meetups and on the web for their excellent help.

