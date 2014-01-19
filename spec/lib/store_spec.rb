require 'rspec'
require './lib/store'

describe 'Store' do
  let(:aStore) { Store::Store.new } #BUG

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

  end

  describe 'Can Report its Content and Metadata.' do

    it '#ProductMetadata gives the list of attributes found in the maximal constructor.' do
      expect(aStore.product_attributes).to eq([:id, :price, :batchPrice, :numberForBatchDiscount])
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

    it "#Clear Resets the Store's population of products back to empty." do
      aStore.add_product('a', 1.0)
      expect{c}.not_to be_nil
      aStore.clear_products_list()
      expect(aStore.product_list_showing_prices_in_pennies()).to match /\[\]/
    end

    it "#Report Describes the Store's contents as a string." do
      aStore.add_product('a', 1.0)
      expect(aStore.product_list_showing_prices_in_pennies).to eq('[{:id=>"a", :price=>1.0, :numberForBatchDiscount=>0, :batchPrice=>0.0}]')
    end

    it '#Report Describes an empty Store as having no elements.' do
      expect(aStore.product_list_showing_prices_in_pennies).to eq("[]")
    end

  end

  describe 'Knows about Dollars, Pennies, and Prices of its Products.' do

    it '#Price_in_pennies: Raises error if price-check an empty store.' do
      expect{aStore.total_pennies_for_quantity('a',1)}.to raise_error(RuntimeError, /No such product./)
    end

    it '#Price_in_pennies: Raises error if price-check an item not in the store.' do
        #add a different product just to be totally sure not making a null case
        aStore.add_product('a',1.0)
        expect{aStore.total_pennies_for_quantity('b',2)}.to raise_error(RuntimeError, /No such product./)
    end

    it '#Price_in_pennies: Returns the non-discounted price in pennies for quantity of one.' do
      s = theStore
      s.add_product('a',1.0)
      expect(s.report).to eq("idk")
      answer = s.total_pennies_for_quantity('a',1)
      #help ="--Q; a,$1,qty=1--"+answer.to_s
      #expect(help).to eq(100)
      expect(answer).to eq(100)
    end

    it '#Price_in_pennies: Returns the non-discounted price in pennies when no discount volume quantity exists.' do
      s = theStore
      s.add_product('a',1.0)
      answer = s.total_pennies_for_quantity('a',9)
      #print "--Q; a,$1,qty=9--"
      expect(answer).to eq(900)
    end

    it '#Price_in_pennies: Returns the discounted total price in pennies for purchase size exactly equal to the discount volume quantity.' do
      s = theStore
      s.add_product('a',1.0,11,100.0)
      answer = s.total_pennies_for_quantity('a',11)
      expect(answer).to eq(10000)
    end

    it '#Price_in_pennies: Returns the minimally discounted total price in pennies for purchase size larger than the discount volume quantity.' do
      s = theStore
      s.add_product('a',100.0,20,1.0)
      answer = s.total_pennies_for_quantity('a',46)
      expect(answer).to eq(60200)
    end

  end

  describe 'FUTURE Possible work.' do
    it 'Refactor Store Validation of Product attributes, not properly consolidated.'
    it 'Product price attributes Allow Fixnum Integers instead of Float only.'
    it 'Refactor Products Map to use symbols instead of strings as hash keys.'  do
      pending 'cf Ruby Design rules; https:\/\/github.com\/styleguide\/ruby'
    end
    it 'Refactor Product into a separate class.'
    it 'Refactor to avoid Raising Exceptions during data input.'
    it 'Can initialize with a list of products.'
  end

end