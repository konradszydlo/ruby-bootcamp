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
    subject = animal;
    loop do
      console.say 'Think of an animal'

      sleep(1)

      # guess animal
      subject = guess_animal subject

      break unless continue_game?
      puts "\n***"

    end
  end

  def guess_animal animal
    animal.guess
  end

  def continue_game?
    console.y_n_question "Play again? #{Console::YES_NO}"
  end

end

console = Console.new
animal = Animal.new console, 'elephant'
play = Play.new console, animal
play.start_game