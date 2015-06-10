class Basket

  attr_reader :items

  def initialize shopping_list
    @items = parse shopping_list
  end

  def parse shopping_list
    shopping_list.lines[1..-1].collect { |item|
      item.chomp.to_sym
    }
  end
end
