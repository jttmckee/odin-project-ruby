require_relative 'board.rb'
require_relative 'player.rb'



class Game

  def initialize


    reset!
    @board = Board.new
    puts "Welcome to Jason's Tic-Tac-Toe Game"
    @player1 = create_player(1, 'X')
    @player2 = create_player(2, 'O')
    playing = @player2
    waiting = @player1
    input = nil
    #Each game one loop
    loop do
      #Each turn one loop
      until victory?
        break if @turns >= @board.cells.size**2
          @board.print_board
          playing, waiting = waiting, playing
          puts "It's #{playing.name}'s turn."
          if playing.name.downcase != "computer"
            #Loop until correct input received
            loop do
              puts "Please enter row and column to mark like this 'A1'.\nType 'Q' to exit"
              input = gets.chomp.upcase
              exit(1) if input == 'Q'
              if input =~ /[A-C][1-3]/
                row = input[0].ord - 65
                col = input[1].to_i - 1
                if @board.mark!(row, col, playing.mark )
                  break
                end
              end
              puts "You entered it incorrectly "
              puts "For example enter A1 for the top left box.\nMake sure you don't try to mark a space that's already been marked. "
              puts "It's still #{playing.name}'s turn."
            end
          else
            ai_play(playing)
          end
          @turns += 1
      end
      @board.print_board
      puts @winner ?  "The winner is #{@winner.name}!" : "It's a tie!"
      puts "Time to play another game.  Type 'Q' to exit, enter to continue"

      exit if 'Q' == gets.chomp
      reset!
      @board.reset!

    end
  end

  def create_player(number, mark)
    puts "Please enter Player #{number}'s name.\nEnter Computer if you want the Computer to play:"
    name = gets.chomp
    name = "Player #{number}" if name == ""
    Player.new(name, mark)

  end

  def victory?
    winning_mark = @board.victory?

    if winning_mark
      @winner = winning_mark == @player1.mark ? @player1 : @player2
      @winner.has_won!
      return true
    else
      return false
    end
  end

  def reset!
    @winner = nil
    @turns = 0
  end

  def ai_play(player)
    #First turn - go to one of the corners
    if @turns == 0
      @board.mark!(rand(2) * 2, rand(2) * 2, player.mark )

      return
    end
    #Second turn - if player has taken corner, take centre, otherwise corner
    if @turns == 1
      if @board.corners.any? {|cell| cell.value != ' '}
        @board.mark!(1,1, player.mark )
        return
      else
        @board.mark!(rand(2) * 2, rand(2) * 2, player.mark )
        return
      end
    end


    #Look for any two in a rows to be completed.
    @board.lines do |line|
      if line.count {|cell| cell.value == player.mark} == 2 &&
        line.count {|cell| cell.value == ' '} == 1
          blank_cell = line.select {|cell| cell.value == ' '}[0]
          @board.mark!(blank_cell.row, blank_cell.column, player.mark )

          return
      end
    end

    #Look for any two in a rows that belong to the other player.  Block them
    @board.lines do |line|
      if line.count {|cell| cell.value != player.mark && cell.value != ' '} == 2 &&
        line.count {|cell| cell.value == ' '} == 1
          blank_cell = line.select {|cell| cell.value == ' '}[0]
          @board.mark!(blank_cell.row, blank_cell.column, player.mark )

          return
      end
    end

    #Look for any lines with one mark and two blanks and check if any of them cross
    potential_cells = []
    useable_cells = []
    @board.lines do |line|
      if line.count {|cell| cell.value == player.mark} == 1 &&
        line.count {|cell| cell.value == ' '} == 2
        potential_cells += line.select {|cell| cell.value == ' '}

      end
    end
    unless potential_cells.empty?
      #Find the cells that match, i.e. more than one cell in potential cells
      useable_cells = potential_cells.select do |cell|
        potential_cells.count(cell) > 1

      end

      if useable_cells.size > 0
        blank_cell = useable_cells.sample
        @board.mark!(blank_cell.row, blank_cell.column, player.mark )
        return
      end
    end


    #If all else fails pick a random free square
    loop do
      row = rand(3)
      col = rand(3)
      break if @board.mark!(row, col, player.mark )
    end
  end

end
