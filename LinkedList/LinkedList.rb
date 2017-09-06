require './Node.rb'

class LinkedList
  attr_accessor :head_node

  def append(node)
    node = make_node(node)
    if @head_node
      @head_node.get_tail_node.next_node = node
    else
      @head_node = node
    end
  end

  def prepend(node)
    node = make_node(node)
    if @head_node
      node.next_node = @head_node
      @head_node = node
    else
      @head_node = node
    end
  end

  def size
    @head_node.count
  end

  def head
    @head_node
  end

  def tail
    @head_node ? @head_node.get_tail_node : nil
  end

  def at(index)
    @head_node ? @head_node.at(index) : nil
  end

  def pop
    unless @head_node then return nil end
    if @head_node.next_node
      @head_node.get_penultimate_node.remove_instance_variable(:@next_node)
    else
      remove_instance_variable(:@head_node)
    end

  end

  def contains?(value)
    find(value) != nil
  end

  def find(data)
    @head_node ? @head_node.find(data, 0) : nil
  end

  def to_s
    @head_node ? @head_node.to_s : "() -> nil"
  end

  def insert_at(object, index)
    node = make_node(object)
    if index <= 0
      node.next_node = @head_node
      @head_node = node
    else
      @head_node ? @head_node.insert_at(node,index) : nil
    end
  end

  def remove_at(index)
    if index <= 0
      if @head_node
        @head_node, return_value = @head_node.next_node, @head_node
        return_value.value
      else
        nil
      end
    else
      @head_node ? @head_node.remove_at(index) : nil
    end

  end

  private
  def make_node(object)
   node = (object.is_a? Node) ? object : Node.new(object)
   node.next_node = nil
   node
  end

end
