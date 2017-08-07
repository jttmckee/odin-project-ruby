require './test.rb'

#This class stores information about people.

class Person
  attr_accessor :name, :age, :gender

  #Create the person object and store their name
  def initialize(name)
    raise MyArgumentError, "No name present!!!" if name.empty?
    @name = name
    @widgets = 0

  end
  # Print this person's _name_ to the screen
  #=Usage
  #==Usage
  #===Usage
  #   person = Person.new
  #   person.print_name
  #Or *just* like this +person.print_name+
  def print_name
    puts "Person called #{@name}"
  end

  #Set number of widgets
  def widgets= (widgets)
    raise ArgumentError, "No argument present!!!" if widgets.empty?
    @widgets = widgets
  end
  #Return number of widgets
  def widgets #:nodoc:
    widgets
  end
end

def cause_trouble
  begin
    yield("")
  rescue MyArgumentError
    puts "rescued by MyArgumentError"
  rescue ArgumentError
    puts "rescued by Argument Error"
  end
end
