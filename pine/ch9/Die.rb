class Die

  def initialize
    # I'll just roll the die, though we
    # could do something else if we wanted
    # to, like setting the die with 6 showing.
    roll
  end

  def roll
    @numberShowing = 1 + rand(6)
  end

  def showing
    @numberShowing
  end

  def cheat number
    number = number.to_i
    if number >= 1 and number <= 6
      @numberShowing = number
    else
      puts "Number must be between 1 and 6"
    end
  end

end

die = Die.new
puts die.showing
die.roll
puts die.showing
die.cheat 4
puts die.showing
die.cheat 2
puts die.showing
die.cheat 10
puts die.showing
