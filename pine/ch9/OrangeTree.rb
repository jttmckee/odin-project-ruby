class OrangeTree
  def initialize
    @age = 0;
    @height = 0;
    @maxAge = 10 + rand(10)
    @orangeCount = 0;

  end

  def ages
    @age = @age + 1
    @height = @height + (rand()+0.5)*0.25/(@age**0.25)
    if @age > 2
      @orangeCount = ((@age**0.5) * 3).to_i
    end
  end

  def pickAnOrange
    if @orangeCount > 0
      @orangeCount = @orangeCount - 1
      puts "Yummy orange.  There are #{@orangeCount} oranges left."
    else
      puts "No oranges left."
    end

  end


  def about
    puts "Orange Tree is #{@age} years old, has #{@orangeCount} oranges, and measures #{@height}m.  "
  end

end

orangeTree = OrangeTree.new

orangeTree.pickAnOrange
orangeTree.ages
orangeTree.about
orangeTree.ages
orangeTree.ages
orangeTree.pickAnOrange
orangeTree.pickAnOrange
orangeTree.pickAnOrange
orangeTree.pickAnOrange
orangeTree.pickAnOrange
orangeTree.pickAnOrange
orangeTree.about
orangeTree.ages
orangeTree.about
