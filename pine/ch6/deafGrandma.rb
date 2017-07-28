
input = ""
ctr = 0
while ctr < 3
  input = gets.chomp
  if input != input.upcase
    puts "HUH?! SPEAK UP, SONNY!"
    ctr = 0
  else
    if input == "BYE"
      if ctr < 3
        puts "DON\'T GO"
        ctr = ctr + 1
      end
    else
      year = 1930 + rand(20)
      puts "NOT SINCE #{year}"
      ctr = 0
    end
  end
end

puts "BYE"
