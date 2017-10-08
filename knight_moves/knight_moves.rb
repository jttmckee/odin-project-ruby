
require './knight.rb'
require './game_board.rb'

Position = Struct.new(:previous_position, :location)

def knight_moves(start,ending)
  unless (start.is_a? Array) && (ending.is_a? Array) && start.size == 2 && ending.size == 2
    puts "You need to enter the positions as two arrays of length 2"
    return nil
  end

  knight = Knight.new(start)
  board = GameBoard.new(knight)

  start_position = Position.new(nil, start)
  positions = [start_position]
  found_position = nil
  ctr = 0

  10000.times do

    current_position = positions.shift
    knight.position = current_position.location
    if current_position.location == ending
      found_position = current_position
      break
    end
    puts knight.position
    knight.legal_moves.each do |move|
      positions.push Position.new(current_position, move)
    end

  end

  if found_position
    path = [found_position]

    loop do
      next_back = path[0].previous_position
      if next_back == nil then break end
      path.unshift next_back
    end
    puts "You made it in #{path.size - 1} moves!  Here's your path:"
    path.each do |position|
      puts position.location
    end
  end
end
