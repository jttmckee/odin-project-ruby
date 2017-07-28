module Enumerable
  def my_each
    type = self.class

    if type == Array || type == Range
      for index in 0...self.size do
        yield( type == Range ? self.to_a[index] : self[index])
      end
    end

    if type == Hash
      keys = self.keys
      for index in 0...keys.size do
        yield(keys[index],  self[keys[index]])
      end
    end
  end

  def my_each_with_index
    type = self.class

    if type == Hash
      puts "error, wrong type"
    elsif type == Array || type == Range
      for index in 0...self.size do
        yield( type == Range ? self.to_a[index] : self[index], index)
      end
    end

  end

  def my_select
    type = self.class
    if type == Array || type == Range
      results = []
      self.my_each do |item|
        results << item if yield(item)
      end
    elsif type == Hash
      results = {}
      self.my_each do |key, value|
        results[key] = value if yield(key, value)
      end
    end

    return results
  end


end

#
# #Tests my_each
# puts "my_each"
# {green: "00FF00", red: "FF0000", blue: "0000FF"}.my_each {|key,item| puts key.to_s + item.to_s}
# [0,5,0,8].my_each {|item| puts item}
# (1..10).my_each {|item| puts item}
# puts "each"
# {green: "00FF00", red: "FF0000", blue: "0000FF"}.each {|key, item| puts key.to_s + item.to_s}
# [0,5,0,8].each {|item| puts item}
# (1..10).each {|item| puts item}
# #Tests my_each_with_index
# puts "my_each_with_index"
# [0,5,0,8].my_each_with_index {|item,index| puts item.to_s + " " +index.to_s}
# (1..10).my_each_with_index {|item,index| puts item.to_s + " " + index.to_s}
# puts "each_with_index"
# [0,5,0,8].each_with_index {|item,index| puts item.to_s + " " +index.to_s}
# (1..10).each_with_index {|item,index| puts item.to_s + " " + index.to_s}
#Tests my_select
puts "my_select"
a = {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.my_select {|key,value| value.size > 4}
puts a
b =  [0,5,0,8].my_select {|number| number > 2}
puts b
c =  (1..100).my_select {|number| number % (number**0.5) == 0  }
puts c
puts "select"
a =  {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.select {|key,value| value.size > 4}
puts a
b =  [0,5,0,8].select {|number| number > 2}
puts b
c = (1..100).select {|number| number % (number**0.5) == 0  }
puts c
