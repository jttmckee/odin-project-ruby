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

  def find(data,counter)
    if data == @value
      counter
    else
        @next_node ? @next_node.find(data, counter+1) : nil
    end

  end

  def to_s
    "(#{value}) -> " + (@next_node ? @next_node.to_s : "nil")
  end

  def insert_at(node,index)

    if index == 1
      node.next_node = @next_node
      @next_node = node
    elsif @next_node == nil
      return nil
    else
      @next_node.insert_at(node, index - 1)
    end
  end

  def remove_at(index)

    if @next_node == nil
      return nil
    elsif index == 1
      @next_node, return_value = @next_node.next_node, @next_node
      return_value.value
    else
      @next_node.remove_at( index - 1)
    end
  end

end
