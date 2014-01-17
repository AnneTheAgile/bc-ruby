require 'rspec'
require './lib/store'

describe 'Store' do
  let(:aStore) { Store::Store.new }

  it '#ProductMetadata gives the list of attributes found in the maximal constructor.' do
    pending 'Test constructor output'
  end

  it '#ConvertDollarsToPennies Rounds up.' do
    expect(aStore.convertDollarsToPennies(1.110)).to eql(111)
    expect(aStore.convertDollarsToPennies(1.111)).to eql(111)
    expect(aStore.convertDollarsToPennies(1.115)).to eql(112)
    expect(aStore.convertDollarsToPennies(1.117)).to eql(112)
  end

  it '#Find_Product Returns true upon searching a product that is in the store.' do
    aStore.add_product('a',1)
    expect(aStore.find_product?('a')).to eq(true)
  end

  it '#Find_Product Returns false upon searching a product that is not in the store.' do
    expect(aStore.find_product?('a')).to eq(false)
  end

  it '#Find_Product Returns false upon searching for an invalid product.'   do
    expect(aStore.find_product?(1)).to eq(false)
  end

  it '#Add_Product Raises error if duplicate product is entered.' do
    aStore.add_product('a',1,2,3)
    expect{aStore.add_product('a',4,5,6)}.to raise_error( RuntimeError,/Duplicate products are not allowed in the store./)
  end

  it '#Add_Product Raises error if discount quantity but not price is entered.' do
    expect{aStore.add_product('a',1,3)}.to raise_error( RuntimeError,/Argument aBatchPrice was not specified but aMinimumBatchQuantity was./)
  end

    it '#Add_Product Raises error if add a new item without any arguments, ie no Id.' do
      expect{aStore.add_product()}.to raise_error ArgumentError
    end

    it '#Add_Product Raises error if add a new item without both Id and Price.' do
      expect{aStore.add_product('a')}.to raise_error ArgumentError
    end

    it '#count is 1 for one element.' do
      expect(aStore.count_products).to eq(0)
      aStore.add_product('a', 1)
      expect(aStore.count_products).to eq(1)
    end

    it '#count is 2 for two elements.' do
      expect(aStore.count_products).to eq(0)
      aStore.add_product('a', 1)
      aStore.add_product('b',2)
      expect(aStore.count_products).to eq(2)
    end

    it '#clear Resets a populated store back to empty.' do
      aStore.add_product('a', 1)
      expect{c}.not_to be_nil
      aStore.clear_products_list()
      expect(aStore.product_list_showing_prices_in_pennies()).to match /\[\]/
    end

    it '#report Describes its contents as a string.' do
      aStore.add_product('a', 1)
      expect(aStore.product_list_showing_prices_in_pennies).to eq('[{:id=>"a", :price=>100, :numberForBatchDiscount=>0, :batchPrice=>0}]')
    end

    it '#report Describes an empty store as having no elements.' do
      expect(aStore.product_list_showing_prices_in_pennies).to eq("[]")
    end


  it '#Price_in_pennies: Raises error if price-check an empty store.' do
    expect{aStore.price_in_pennies('a',1)}.to raise_error(RuntimeError, /No such product./)
  end

  it '#Price_in_pennies: Raises error if price-check an item not in the store.' do
      #add a different product just to be totally sure not making a null case
      aStore.add_product('a',1)
      expect{aStore.price_in_pennies('b',2)}.to raise_error(RuntimeError, /No such product./)
  end

  it '#Price_in_pennies: Returns the price in pennies for quantity of one.' do
    aStore.add_product('a',1)
    answer = aStore.price_in_pennies('a',1)
    expect(answer).to eq(100)
  end

  it '#Price_in_pennies: Returns the non-discounted price in pennies when there is no discount volume quantity.' do
    aStore.add_product('a',1)
    answer = aStore.price_in_pennies('a',9)
    expect(answer).to eq(900)
  end

  it '#Price_in_pennies: Returns the discounted total price in pennies for purchase size exactly equal to the discount volume quantity.' do
    aStore.add_product('a',1,11,100)
    answer = aStore.price_in_pennies('a',11)
    expect(answer).to eq(10000)
  end

  it '#Price_in_pennies: Returns the minimally discounted total price in pennies for purchase size larger than the discount volume quantity.' do
    aStore.add_product('a',100,20,1)
    answer = aStore.price_in_pennies('a',46)
    expect(answer).to eq(60200)
  end

  context 'FUTURE Possible Refactorings.' do
    it 'Products Map Uses symbols instead of strings as hash keys.'  do
      pending 'cf Ruby Design rules; https:\/\/github.com\/styleguide\/ruby'
    end
  end

end