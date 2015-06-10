class PriceList < Hash
  def initialize price_list
    parse price_list
  end

  def get_price_in_pence price
    price.gsub(/\./, "").to_f
  end

  def parse price_list
    price_list.scan(/(\w+) = £?([\d.]+)p?/).each { |item_price|
      item, price = item_price.first.to_sym, get_price_in_pence( item_price.last )
      self[item] = price
    }
  end
end
