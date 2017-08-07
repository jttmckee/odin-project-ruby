class Board

  attr_reader :cells

  def initialize
    reset!
  end

  def reset!
    @cells = Array.new(3) { Array.new(3,' ') }
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
            print "#{@cells[(row)/2 - 1][(column)/2 - 1]} "
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
    if @cells[row][column] == ' '
      @cells[row][column] = mark
      return true
    else
      return false
    end
  end

  def victory?
    winning_mark = nil
    #Check all the rows
    @cells.each do |row|
      winning_mark = row[0] if row[0] != ' ' && checkMatch?(row)
    end

    #Check columns

    @cells.size.times do |column|
      temp_array = []
      @cells.size.times do |row|
        temp_array << @cells[row][column]
      end
      winning_mark = temp_array[0] if temp_array[0] != ' ' && checkMatch?(temp_array)
    end

    #Check 1st diagonal
    temp_array = []
    @cells.size.times do |ctr|
      temp_array << @cells[ctr][ctr]
    end
    winning_mark = temp_array[0] if temp_array[0] != ' ' && checkMatch?(temp_array)

    #Check 2nd diagonal
    temp_array = []
    @cells.size.times do |ctr|
      temp_array << @cells[ctr][@cells.size - (ctr+1)]
    end
    winning_mark = temp_array[0] if temp_array[0] != ' ' && checkMatch?(temp_array)

    return winning_mark

  end

  def lines

  end
  private
  def checkMatch?(line)
    line.max == line.min
  end

end
