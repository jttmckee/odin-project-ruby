puts "Press enter after each word.  Blank line to stop."
words = []
input = "not used"
while input != ""
  input = gets.chomp
  words.push input
end
#puts words.sort
newWords = []

words.each do |word|
  i = 0
  while i < newWords.length
    if word < newWords[i]
      newWords.insert(i,word)
      break
    end
    i=i+1
  end
  if newWords == []
    newWords[0] = word
  end
end
puts newWords
