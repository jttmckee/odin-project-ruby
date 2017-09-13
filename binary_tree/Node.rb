class Node
  attr_reader :left_node, :right_node , :parent_node, :value

  def initialize(value)
    @value = value
  end

  def child_node=(object)
    if object == nil then return end
    node = make_node(object)
    if node.value <= @value
      if @left_node
        @left_node.child_node = node
      else
         @left_node  =  node
        @left_node.parent_node = self
      end
    else
      if @right_node
        @right_node.child_node = node
      else
        @right_node  =  node
        @right_node.parent_node = self
      end
    end
  end

  def child_nodes
    [left_node,right_node]
  end

  def parent_node=(object)
    node  = make_node(object)
    if node.has_child(self)
      if @parent_node && !@parent_node.has_child(node)
        @parent_node.child_node = node
      end
    else
      node.child_node = self
    end
    @parent_node = node

  end

  def has_child(node)
    @left_node == node || @right_node == node
  end

  private
  def make_node(object)
     node = ( (object.is_a? Node ) ? object : Node.new(object) )
    node
  end


end


def build_tree(array)
  node = Node.new(array[0])
  array[1..-1].shuffle.each do |element|
    node.child_node = element
  end
  node
end

def breadth_first_search(node,value)
  queue = [node]
  loop do
    if queue.empty? then return nil end
    check_node = queue.pop
    puts "Checking #{check_node.value} "
    if value == check_node.value then return check_node end
    if check_node.left_node then queue.unshift check_node.left_node end
    if check_node.right_node then queue.unshift check_node.right_node end

  end

end
