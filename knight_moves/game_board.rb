require './knight.rb'

class GameBoard

  attr_reader :knight


  def initialize(knight=Knight.new)
    @height = 8
    @width = 8
    self.knight = knight
  end

  def knight= (knight)
    if knight.is_a? Knight
      @knight = knight
      @knight.board = self
    end
  end

  def [](x,y)
    x.between?(0,@width-1) && y.between?(0,@height-1)

  end


end
