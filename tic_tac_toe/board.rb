class Board
  require_relative 'cell.rb'
  attr_reader :cells

  def initialize
    reset!
  end

  def reset!
    @cells = Array.new(3) {|row| Array.new(3) { |col| Cell.new(' ', row, col)} }
  end

  def print_board
    letter = '@'
    (@cells.size * 2 + 2).times do |row|
      print " " * @cells.size * 2
      if row == 0
        number = '0'
        print '  |'
        @cells.size.times { print ' ' + number.next! + ' |'}
        print "\n"

      elsif row.odd?
        print ' '
        puts ' -' * (@cells.size * 2 + 1)
      else
      (@cells.size * 2 + 2).times do |column|
          if column.odd?
            print '| '

          elsif column == 0
            print letter.next! + ' '
          else
            begin
            print "#{@cells[(row)/2 - 1][(column)/2 - 1].value} "
            rescue
              puts "#{row} #{column}"
            end
          end
        end
        print "\n"
      end
    end
  end

  def mark!(row,column,mark)
    if @cells[row][column].value == ' '
      @cells[row][column].value  = mark
      return true
    else
      return false
    end
  end

  def victory?
    winning_mark = nil

    lines { |line| winning_mark = line[0].value if line[0].value != ' ' && checkMatch?(line) }

    return winning_mark

  end

  def lines
    #Check all the rows
    @cells.each do |line|
      yield(line)
    end
    #Check columns

    @cells.size.times do |column|
      line = []
      @cells.size.times do |row|
        line << @cells[row][column]
      end
      yield(line)
    end
    #Check 1st diagonal
    line = []
    @cells.size.times do |ctr|
      line << @cells[ctr][ctr]
    end
    yield(line)

    #Check 2nd diagonal
    line = []
    @cells.size.times do |ctr|
      line << @cells[ctr][@cells.size - (ctr+1)]
    end
    yield(line)

  end


  private
  def checkMatch?(line)
    line.inject(true) {|memo, cell| memo = (line[0].value == cell.value)}
  end

end
