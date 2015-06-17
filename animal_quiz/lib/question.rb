class Question

  attr_reader :question, :yes_answer, :no_answer, :console

  def initialize question, yes, no, console
    @question = question
    @yes_answer = yes
    @no_answer = no
    @console = console
  end

  def console
    @console
  end

  def guess
    if console.y_n_question @question
      @yes_answer = @yes_answer.guess
    else
      @no_answer = @no_answer.guess
    end
    self
  end

  def ==(other)
    self.question == other.question && self.yes_answer == other.yes_answer && self.no_answer == other.no_answer
  end
end