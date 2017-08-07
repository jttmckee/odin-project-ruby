class Dungeon
  attr_accessor :player
  def initialize(player)
    @player = player
    @rooms = {}
  end

  def add_room(reference, name, description, connections)
    @rooms[reference] = Room.new(reference,name,description,connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms[reference]
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

end

Player = Struct.new(:name, :location)
Room = Struct.new(:reference, :name, :description, :connections) do
  def full_description
    name + "\n\nYou are in " + description
  end

end

me = Player.new("Jason McKee")
my_dungeon = Dungeon.new(me)

my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {west: :smallcave})
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {east: :largecave})

my_dungeon.start(:largecave)
my_dungeon.go(:west)
