class Hangman

  def getLetter
    puts "Guess a letter (A - Z).  Only the first letter counts"
    letter =  gets[0].upcase

  end

  def printLetters(word)
    print "\n"
    (5 - @lives).times do |i|
      puts @scaffold[i]
    end
    puts "\n"

    print "WORD:"
    word.each_char do |chr|
      print @letters.include?(chr) ? chr : '_'
      print ' '
    end

  end

  def setup
    @lives = 5
    @scaffold = []
    @scaffold << "     --------"
    @scaffold << "        |"
    @scaffold << "        O"
    @scaffold << "       -|-"
    @scaffold << "       / \\"
    @letters = []

  end


  def initialize
    setup
    incorrect_letters = []
    words = File.readlines('5desk.txt')
    word = ""
    letter = ""
    until (word.size <= 11 && word.size >= 5)
      word = words[rand(words.size)].chomp.upcase
    end
    hasWon = false

    until (@lives<=0 || hasWon)
      printLetters(word)
       loop do
         letter = getLetter

        if incorrect_letters.include?(letter) or @letters.include?(letter)
          puts "You already guessed that letter."
        elsif letter =~ /[A-Z]/
          break
        else
          puts "That's not a letter!"
        end
      end

      puts "You guessed \"#{letter}\""
      if word.include? letter
        puts "That's right! Well done..."
        @letters << letter
        if word.split('').all? {|chr| @letters.include?(chr)} then hasWon = true end
      else
        @lives -= 1
        puts "That's wrong! You have #{@lives} lives left."
        incorrect_letters << letter

      end

    end

    if hasWon
      puts "You win!"
    else

      puts "You lose!"
    end
    puts "The word is \"#{word}\""
  end


end


a = Hangman.new
