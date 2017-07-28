puts "Start year?"
startYear = gets.chomp.to_i
puts "End year?"
endYear = gets.chomp.to_i

year = startYear

while year <= endYear
  if ((year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0)))
    puts "Leap Year: #{year}"
  end
  year = year + 1
end
