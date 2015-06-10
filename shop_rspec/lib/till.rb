class Till

  attr_reader :price_list

  def initialize price_list
    @price_list = price_list
  end

  def total basket
    prices = basket.items.collect do |item|
      price_list[item]
    end
    prices.reduce(&:+)/100
  end

end
