class Node
  attr_accessor :value, :parent_node
  attr_reader :left_node, :right_node

  def initialize(value)
    @value = value
  end

  def child_node=(object)
    if object == nil then return end
    node = make_node(object)
    puts node
    puts @value
    if node.value <= @value
      if @left_node && node.value < @left_node.value
        @left_node.child_node = node
      else
        node.child_node, @left_node = @left_node, node
        @left_node.parent_node = self
      end
    else
      if @right_node && node.value > @right_node.value
        @right_node.child_node = node
      else
        node.child_node, @right_node = @right_node, node
        @right_node.parent_node = self
      end
    end
  end

  private
  def make_node(object)
     node = ( (object.is_a? Node ) ? object : Node.new(object) )
    node
  end
end
