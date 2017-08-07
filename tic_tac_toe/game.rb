require_relative 'board.rb'
require_relative 'player.rb'



class Game

  def initialize



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

      end
      @board.print_board
      puts "The winner is #{@winner.name}!"
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
  end

  def ai_play(player)

    # @board.lines do |line|
    #   if line.count(player.mark) == 2 && line.count(' ') == 1
    #     @board.mark!(row, col, player.mark )
    #   end
    # end

    loop do
      row = rand(3)
      col = rand(3)
      break if @board.mark!(row, col, player.mark )
    end
  end

end
