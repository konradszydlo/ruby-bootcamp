require_relative '../lib/question'

class Animal

  attr_reader :console, :name

  def initialize( console, name )
    @console = console
    @name = name
  end

  def console
    @console
  end

  def guess
    if animal_guessed?
      correct_guess
      self
    else
      incorrect_guess
    end
  end

  def animal_guessed?
    console.y_n_question "Is it #{name} #{Console::YES_NO} ?"
  end

  def correct_guess
    console.say "I win. Pretty smart aren't I?"
  end

  def incorrect_guess
    console.say 'You win. help me learn from my mistake before you go...'
    animal = ask_for_correct_animal
    question = ask_for_distinguishing_question animal, @name
    answer = ask_for_answer_to_distinguishing_question animal
    console.say 'Thanks'
    save_question animal, question, answer
  end

  def ask_for_correct_animal
    console.ask 'What animal were you thinking of?'
  end

  def ask_for_distinguishing_question human_animal, ai_animal
    console.ask "Give me a question to distinguish #{human_animal} from #{ai_animal}"
  end

  def ask_for_answer_to_distinguishing_question animal
    console.y_n_question "For #{animal} what is the answer to your question #{Console::YES_NO}"
  end

  def save_question animal, question, answer
    if answer
      Question.new(question, Animal.new(console, animal), self, console)
    else
      Question.new(question, self, Animal.new(console, animal), console)
    end
  end

  def ==(other)
    self.name == other.name
  end
end