

class Knight

  attr_accessor :board

  def initialize(x=0,y=0)
    @x = x
    @y = y
  end

  def legal_moves
    moves = [ [@x-2,@y-1],[@x-2,@y+1],[@x+2,@y-1],[@x+2,@y+1],
              [@x-1,@y+2],[@x-1,@y-2],[@x+1,@y+2],[@x+1,@y-2]]
    moves.select! do |pos|
      @board[pos[0],pos[1]]
    end

  end


  def move_to(position)
    unless possible_move?(position)
      puts "Not a legal move"
      return nil
    end

    if legal_moves.include? position
      @x = position[0]
      @y = position[1]
    end

  end


  def possible_move?(position)
    unless ( position.is_a? Array ) && position.length == 2 then return false end
    board[position[0],position[1]]
  end



end
