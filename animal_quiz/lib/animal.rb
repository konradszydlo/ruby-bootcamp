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
    if console.y_n_question "Is it #{name}"
      console.say ''
    end
  end

end