

def GrandfatherClock &block
  theTime = Time.now.hour.to_i
  numTimes = (1 - ((theTime % 12 + 11) / 12)) * 12 + theTime % 12
  numTimes.times do
    block.call
  end
end

 GrandfatherClock do
   puts "Hello"
 end
