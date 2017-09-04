class Node
  attr_accessor :value, :next_node
  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end

  def get_tail_node
    @next_node ? @next_node.get_tail_node : self
  end

  def count
    @next_node ? @next_node.count + 1 : 1
  end

  def get_penultimate_node
    @next_node.next_node ? @next_node.get_penultimate_node : self
  end

  def at(index)
    if index == 0
       self
    else
      @next_node ?  @next_node.at(index - 1) : nil
    end
  end
end
