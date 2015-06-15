require_relative 'console'
require_relative 'animal'

class Play

  attr_reader :console, :animal

  def initialize( console, animal )
    @console = console
    @animal = animal
  end

  def console
    @console
  end

  def start_game
    loop do
      console.ask 'Think of an animal'
      # guess animal
      animal.guess

      break unless console.y_n_question 'Play again?'
      puts "\n***"

    end

  end
end

console = Console.new
animal = Animal.new 'rabbit'
play = Play.new console, animal
play.start_game