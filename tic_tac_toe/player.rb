class Player

  attr_reader :name, :score

  attr_accessor :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
    @score = 0
  end

  def has_won!
    @score += 1
  end

end
