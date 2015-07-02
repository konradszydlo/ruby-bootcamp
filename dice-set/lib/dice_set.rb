
class DiceSet
  attr_accessor :values

  def roll(how_many)
    @values = []
    how_many.times {
      values << rand(1..6)
    }
  end
end

dice = DiceSet.new

dice.roll(5)
puts "#{dice.values}"

dice.roll(5)
puts "#{dice.values}"