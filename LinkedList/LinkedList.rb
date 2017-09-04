require './Node.rb'

class LinkedList
  attr_accessor :head_node

  def append(node)
    unless node.is_a? Node then node = Node.new(node) end
    if @head_node
      @head_node.get_tail_node.next_node = node
    else
      @head_node = node
    end
  end


end
