require 'rspec'
require './lib/store'

describe 'Store' do
  let(:aStore) { Store::Store.new } #BUG when try to access members

  def theStore
    Store::Store.new
  end

  describe '#Add_Product' do

    it 'Raises error if add a new item without any arguments, ie no Id.' do
      expect{aStore.add_product()}.to raise_error ArgumentError
    end

    it 'Raises error if add a new item without both Id and Price.' do
      expect{aStore.add_product('a')}.to raise_error ArgumentError
    end

    it 'Raises error if the given ID is not a string.' do
      expect{aStore.add_product(1,1.0)}.to  raise_error(RuntimeError, /Argument .* not a string./)
    end

    it 'Raises error if duplicate product ID is entered.' do
      aStore.add_product('a',1.0,2,3.0)
      expect{aStore.add_product('a',4.0,5,6.0)}.to raise_error( RuntimeError,/Duplicate products are not allowed in the store./)
    end

    it 'Allows the given Price to be convertible to a float, eg 1 not 1.0.' do
      expect{aStore.add_product('a',1)}.not_to  raise_error
    end

    it 'Raises error if the given Discount quantity is not an integer.' do
      expect{aStore.add_product('a',1.0,2.2)}.to raise_error( RuntimeError)
      #,/Argument aMinimumBatchQuantity is non-integer./)
      #Actually now get;
      # Argument aBatchPrice 0.0 was not specified but aMinimumBatchQuantity 2.2 was.
    end

    it 'Raises error if the given Batch Price is not convertible to a float.' do
      expect{aStore.add_product('a',1.0,'b',9)}.to raise_error( RuntimeError,/Argument b is not convertible to an integer./)
    end

    it 'Raises error if Discount quantity but not price is entered.' do
      expect{aStore.add_product('a',1.0,2)}.to raise_error( RuntimeError,/Argument aBatchPrice .* was not specified but aMinimumBatchQuantity .* was./)
    end

    it "#Add_product: Converts a String input for BatchQuantity (numberForBatchDiscount) to integer (Fix ISSUE#01 In CLI, Exception upon specify a non-zero numberForBatchDiscount - due to Ruby Gets produces Strings, and Ruby argument parser converts only perceived floats, not integers." do
      expect{aStore.add_product('a','1','2','3')}.not_to  raise_error
      expect(aStore.inspect.to_s).to match /:numberForBatchDiscount=>2/
      expect(aStore.inspect.to_s).to match /:price=>1.0/
      #/"products=[{:id=>"a\", :price=>1.0, :numberForBatchDiscount=>2, :batchPrice=>3.0}]"/
    end

  end

  describe 'Can Modify its Content.' do

    it '#Add_product_map enables adding a new item as a preformed hashmap.' do
      aMap = {:id=>"a", :price=>3, :numberForBatchDiscount=>2, :batchPrice=>2}
      aStore = theStore
      aStore.add_product_map(aMap)
      expect(aStore.report).to eq("[{:id=>\"a\", :price=>3.0, :numberForBatchDiscount=>2, :batchPrice=>2.0}]")
    end

    it "#Clear Resets the Store's population of products back to empty." do
      aStore.add_product('a', 1.0)
      expect{c}.not_to be_nil
      aStore.clear_products_list()
      expect(aStore.product_list_showing_prices_in_dollars()).to match /\[\]/
    end

  end

  describe 'Can Report its Content and Metadata.' do

    it '#ProductMetadata gives the list of attributes found in the maximal constructor.' do
      expect(aStore.product_attributes).to eq([:id, :price, :numberForBatchDiscount, :batchPrice])
    end

    it '#Find_Product Returns true upon searching a product that is in the store.' do
      aStore.add_product('a',1.0)
      expect(aStore.find_product?('a')).to eq(true)
    end

    it '#Find_Product Returns false upon searching a product that is not in the store.' do
      expect(aStore.find_product?('a')).to eq(false)
    end

    it '#Count is 1 for one element.' do
      expect(aStore.count_products).to eq(0)
      aStore.add_product('a', 1.0)
      expect(aStore.count_products).to eq(1)
    end

    it '#Count is 2 for two elements.' do
      expect(aStore.count_products).to eq(0)
      aStore.add_product('a', 1.0)
      aStore.add_product('b',2.0)
      expect(aStore.count_products).to eq(2)
    end

    it "#Report Describes the Store's contents as a string." do
      aStore.add_product('a', 1.0)
      expect(aStore.report).to eq('[{:id=>"a", :price=>1.0, :numberForBatchDiscount=>0, :batchPrice=>0.0}]')
    end

    it "#Product_list_showing_prices_in_dollars Describes the Store's contents as a string." do
      aStore.add_product('a', 1.0)
      expect(aStore.product_list_showing_prices_in_dollars).to eq('[{:id=>"a", :price=>1.0, :numberForBatchDiscount=>0, :batchPrice=>0.0}]')
    end

    it '#Product_list_showing_prices_in_dollars Describes an empty Store as having no elements.' do
      expect(aStore.product_list_showing_prices_in_dollars).to eq("[]")
    end

  end

  describe 'Knows about Dollars, Pennies, and Prices of its Products.' do

    it '#Price_in_dollars_for_quantity: Raises error if price-check an empty store.' do
      expect{aStore.price_in_dollars_for_quantity('a',1)}.to raise_error(RuntimeError, /No such product./)
    end

    it '#Price_in_dollars_for_quantity: Raises error if price-check an item not in the store.' do
        #add a different product just to be totally sure not making a null case
        aStore.add_product('a',1.0)
        expect{aStore.price_in_dollars_for_quantity('b',2)}.to raise_error(RuntimeError, /No such product./)
    end

    it '#Price_in_dollars_for_quantity: Returns the non-discounted price in pennies for quantity of one.' do
      s = theStore
      s.add_product('a',1.0)
#      expect(s.report).to eq("idk")
      answer = s.price_in_dollars_for_quantity('a',1)
      #help ="--Q; a,$1,qty=1--"+answer.to_s
      #expect(help).to eq(100)
      expect(answer).to eq(1)
    end

    it '#Price_in_dollars_for_quantity: Returns the non-discounted price in pennies when no discount volume quantity exists.' do
      s = theStore
      s.add_product('a',1.0)
      answer = s.price_in_dollars_for_quantity('a',9)
      expect(answer).to eq(9)
    end

    it '#Price_in_dollars_for_quantity: Returns the discounted total price in pennies for purchase size exactly equal to the discount volume quantity.' do
      s = theStore
      s.add_product('a',1.0,11,100.0)
      answer = s.price_in_dollars_for_quantity('a',11)
      expect(answer).to eq(100)
    end

    it '#Price_in_dollars_for_quantity: Returns the minimally discounted total price in pennies for purchase size larger than the discount volume quantity.' do
      s = theStore
      s.add_product('a',100.0,20,1.0)
      answer = s.price_in_dollars_for_quantity('a',46)
      expect(answer).to eq(602)
    end

  end

  describe 'FUTURE possible work.' do
    it 'Product entry refuses BatchPrice > Standard Price.'
    it 'Refactor Store Validation to use Type Casting instead of checking ValidAsXType.'
    it 'Refactor to avoid Raising Exceptions during data input validation.'
    it 'Refactor Products Map to use symbols instead of strings as hash keys.'  do
      pending 'cf Ruby Design rules; https:\/\/github.com\/styleguide\/ruby'
    end
    it 'Refactor Product into a separate class.'
    it 'Can initialize with a list of products.'
  end

end