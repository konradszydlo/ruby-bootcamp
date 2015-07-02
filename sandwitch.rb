# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points


def score(dice)
  # You need to write this method
  if dice.empty?
    return 0
  end
  total = 0
  dice.sort!
  if dice.size >= 3
    dice.each_slice(3) do |slice|
      if slice.uniq.size == 1
        if slice.first == 1
          total += 1000
        else
          total += get_single_score_points slice
        end
      else
        total += get_single_score_points slice
      end

    end
  else
    total += get_single_score_points dice
  end
  total
end

def get_single_score_points(dice)
  total = 0
  dice.each do |n|
    if n == 1
      total += 100
    elsif n == 5
      total += 50
    end
  end
  total
end

def print_total(dice)
  total = score dice
  puts "total is #{total}"
end

# total = score([1,5,1,1,1])

# total = score([1,2,1,5,4])

# print_total [5]

# print_total [1, 5, 5, 1]

print_total [2, 2, 2]


