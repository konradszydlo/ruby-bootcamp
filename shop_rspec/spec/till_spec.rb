
class Till
  attr_reader :basket, :price_list

  def initialize(basket, price_list)
    @basket = basket
    @price_list = price_list
  end

  def total
    prices = basket.items.collect { |item| price_list[item] }
    "£#{'%.2f' % (prices.reduce(&:+)/100)}"
  end
end

class Basket
  attr_reader :items

  def initialize shopping_list
    @items = parse(shopping_list)
  end

  def parse shopping_list
    shopping_list.lines[1..-1].collect do |item|
      item.strip.chomp.to_sym
    end
  end

  def add(item)
    items << item.to_sym
  end
end

class Currency
  attr_reader :major, :minor

  def initialize(major, minor)
    @major = major
    @minor = minor
  end

  def convert(value)
    raise NotImplementedError
  end

  def strip_currency_signs(price)
    raise NotImplementedError
  end
end

class GreatBritishPound < Currency

  def initialize
    super('£', 'p')
  end

  def strip_currency_signs(price)
    price.gsub(/^#{major}|#{minor}$/, '').to_f
  end

  def convert(price)
    raw = strip_currency_signs(price)
    case price
      when /^#{major}/
        raw * 100
      when /#{minor}$/
        raw
      else
        raw
    end.round(2)
  end

end

class Euro < Currency

  def initialize
    super('€', 'c')
  end

  def strip_currency_signs(price)
    price.gsub(/[#{major}#{minor}]$/, '').to_f
  end

  def convert(price)
    raw = strip_currency_signs(price)
    case price
      when /#{major}$/
        raw * 100
      when /#{minor}$/
        raw
      else
        raw
    end.round(2)
  end

end

class PriceList
  attr_reader :prices, :currency

  def initialize(price_list, currency)
    @currency = currency
    @prices = parse(price_list)
  end

  def parse(price_list)
    price_list.scan(/(\w+) = (\S+)/).collect do |item_price|
      item = item_price.first.to_sym
      price = currency.convert( item_price.last )
      [item, price]
    end.to_h
  end

  def [](key)
    @prices[key]
  end

  def add(key, value)
    prices[key.to_sym] = currency.convert(value)
  end
end

describe Basket do

  let(:shopping_list) do
    <<-STRING
      list
      apple
      orange
    STRING
  end

  let(:basket) { described_class.new(shopping_list) }
  let(:items) { basket.items }

  subject { basket }

  describe '#initialize' do

    it 'should parse items out correctly' do
      expect(items).to eq([:apple, :orange])
    end

  end

  describe '#add' do

    before do
      basket.add('steak')
    end

    it 'will add an item to the basket' do
      expect(items).to eq([:apple, :orange, :steak])
    end
  end
end


describe 'Currencies' do

  describe GreatBritishPound do

    subject { described_class.new }

    describe "#strip_currency_signs" do
      it "returns price without currency major sign" do
        expect(subject.strip_currency_signs("£1.20")).to eq(1.2)
      end

      it "returns price without currency minor sign" do
        expect(subject.strip_currency_signs("35p")).to eq(35)
      end

    end

    describe "#convert" do

      context 'prices < one hundred pounds or including decimal point' do

        it 'converts pounds and pence to pence' do
          expect(subject.convert("£1.10")).to eq(110)
        end

      end

      context 'prices > one hundred pounds' do

        it 'accepts prices over 100 without decimal points' do
          expect(subject.convert("£100")).to eq(10000)
        end

        it 'accepts prices over 100 with decimal point' do
          expect(subject.convert("£100.10")).to eq(10010)
        end

      end

    end

  end

  describe Euro do

    subject { described_class.new }

    describe "#strip_currency_signs" do
      it "returns price without currency major signs" do
        expect(subject.strip_currency_signs("1.10€")).to eq(1.1)
      end

      it "returns price without currency minor sign" do
        expect(subject.strip_currency_signs("20c")).to eq(20)
      end

    end

    describe "#convert" do
      it 'converts euros to eurocents' do
        expect(subject.convert("1.10€")).to eq(110)
      end
    end

  end

end

describe PriceList do

  let(:currency) { GreatBritishPound.new }
  let(:list) { "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34 steak = £30" }

  subject { described_class.new(list, currency).prices }

  describe "#parse" do

    it 'should return the parsed list' do
      expect(subject).to eq({
                                :orange => 10.0,
                                :apple => 20.0,
                                :bread => 110.0,
                                :tomato => 25.0,
                                :cereal => 234.0,
                                :steak => 3000.0
                            })
    end

  end

  describe '#add' do
    subject(:p_list) { described_class.new(list, currency) }
    before do
      p_list.add('cheese', '£2.00')
    end
    it 'will add an item to the price list' do
      expect(p_list.prices).to eq({
                                      :orange => 10.0,
                                      :apple => 20.0,
                                      :bread => 110.0,
                                      :tomato => 25.0,
                                      :cereal => 234.0,
                                      :steak => 3000.0,
                                      :cheese => 200.0
                                  })
    end
  end
end

describe Till do

  let(:shopping_list) do
    <<-STRING
      list
      apple
      orange
    STRING
  end

  let(:currency) { GreatBritishPound.new }
  let(:price_list_raw) { "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34" }
  let(:price_list){ PriceList.new(price_list_raw, currency) }
  let(:basket){ Basket.new(shopping_list) }

  subject { described_class.new(basket, price_list) }

  describe '#total' do

    it 'returns the total in pounds and pence' do
      expect(subject.total).to eq("£0.30")
    end

  end

end