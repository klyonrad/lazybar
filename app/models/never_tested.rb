class NeverTested
  include NotExistingNamespace::WeirdModule
  SOME_CONSTANT = CONSTANT_THAT_DOES_NOT_EXIST::REALLY_NOT
  FOO = puts('IS EXECUTED')
  # RAISE_CONSTANT = raise('Wow, Ruby can be crazy.')

  def dead_method
    puts 'DEAD METHOD IS CALLED'
  end
end
