puts 'What is your favourite number?'
fNumber = gets.chomp.to_i
newFav = (fNumber + 1).to_s
puts "A bigger, better number could be #{newFav}"
