class Console

  def ask( question )
    puts question
    gets.chomp
  end

  def y_n_question( question )
    answer = ask question
    answer =~ /[Yy]/
  end

  def say ( message )
    puts message
  end

end