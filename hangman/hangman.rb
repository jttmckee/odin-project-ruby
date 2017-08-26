class Hangman

  def getLetter
    puts "Guess a letter (A - Z).  Only the first letter counts"
    letter =  gets[0].upcase

  end

  def printLetters(word, letters)
    print "WORD:"
    word.each_char do |chr|
      print letters.include?(chr) ? chr : '_'
      print ' '
    end
    print "\n"
  end


  def initialize
    lives = 5
    letters = []
    words = File.readlines('5desk.txt')
    word = ""
    until (word.size <= 11 && word.size >= 5)
      word = words[rand(words.size)].chomp.upcase
    end
    printLetters(word, letters)
    hasWon = false

    until (lives<=0 || hasWon)
      letter = getLetter

      until letter =~ /[A-Z]/
        puts "That's not a letter!"
        letter = getLetter
      end

      puts "You guessed \"#{letter}\""
      if word.include? letter
        puts "That's right! Well done..."
        letters << letter
        if word.split('').all? {|chr| letters.include?(chr)} then hasWon = true end
      else
        puts "That's wrong!"
        lives -= 1

      end
      printLetters(word, letters)

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
