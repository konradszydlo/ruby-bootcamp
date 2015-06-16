class Question

  attr_reader :question, :yes_animal, :no_animal

  def initialize question, yes_animal, no_animal
    @question = question
    @yes_animal = yes_animal
    @no_animal = no_animal
  end
end