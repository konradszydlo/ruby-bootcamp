require 'price_list'
require 'basket'
require 'till'

describe PriceList do

  let(:price_list_original) do
    "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34"
  end

  let(:price_list_array) do
    [["orange", "10"], ["apple", "20"], ["bread", "1.10"],["tomato", "25"],["cereal", "2.34"
]]
  end

  let(:price_list_hash) do
    {:orange=>10.0, :apple=>20.0, :bread=>110.0, :tomato=>25.0, :cereal=>234.0}
  end

  let(:price_list) do
    PriceList.new price_list_original
  end


  describe "#parse" do
    it "should return a new list with price-item as key value pairs" do
      expect(price_list.parse(price_list_original)).to eql(price_list_array)
    end
  end

  describe "#get_price_in_pence" do
    it "should convert punds to pences" do
      expect(price_list.get_price_in_pence("10p")).to eql(10.0)
    end
  end

end

describe Basket do

  let(:shopping_list_original) do
    <<LIST
list
orange
apple
apple
orange
tomato
cereal
bread
orange
tomato
LIST
  end

  let(:shopping_list_array) do
    [:orange, :apple, :apple, :orange, :tomato, :cereal, :bread, :orange, :tomato]
  end

  let(:basket) do
    Basket.new shopping_list_original
  end

  describe "#parse" do
    it "should return an array of symbols from passed shopping list" do
      expect(basket.parse(shopping_list_original)).to eql(shopping_list_array)
    end
  end

  describe "#initialise" do
    it "should parse shopping list passed and populate items instance variable" do
      expect(basket.items).to eql(shopping_list_array)

    end
  end

end

describe Till do
  describe "'total" do
    it "gets total for a basket using price list provided" do
     basket = double
     price_list = double

     allow(Basket).to receive(:items) { [:orange, :apple, :apple, :orange, :tomato, :cereal, :bread, :orange, :tomato] }


     Till.new(price_list).total(basket)
    end
  end
end
