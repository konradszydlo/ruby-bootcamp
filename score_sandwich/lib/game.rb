
class Game
  SPECIAL_NUMBERS = { 1 => 100, 5 => 50 }

  def score(dice)
    if dice.empty?
      return 0
    end

    dice.sort!
    total = 0
    if dice.size >= 3
      tripples = dice.slice!(0,3)
      if tripples.uniq.size == 1
        total += tripples.first == 1 ? 1000 : (tripples.first * 100)
      else
        total += calculate_single_scores tripples
      end
      unless dice.empty?
        total += calculate_single_scores dice
      end
    else
      total += calculate_single_scores dice
    end
    total
  end

  def calculate_single_scores(dice)
    dice.reduce(0) do |sum, n|
      sum + SPECIAL_NUMBERS.fetch(n, 0)
    end
  end
end

# data = [1,1,1, 1, 4, 1]
data = [1, 5, 5, 1]

Game.new.score(data)