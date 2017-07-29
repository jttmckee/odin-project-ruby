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

        results[key] = value if value != nil && yield(key, value)
      end
    end

    return results
  end

  def my_all?
    unless block_given?
      return self.my_select { |obj| obj} == self
    else
      test = self.my_select { |key,value| yield(key,value) } if self.class == Hash
      test = self.my_select { |item| yield(item) } if self.class == Array ||  self.class == Range
      return test == (self.class == Range ? self.to_a : self)
    end
  end



end

#
# #Tests my_each
# # puts "my_each"
# # {green: "00FF00", red: "FF0000", blue: "0000FF"}.my_each {|key,item| puts key.to_s + item.to_s}
# # [0,5,0,8].my_each {|item| puts item}
# # (1..10).my_each {|item| puts item}
# # puts "each"
# # {green: "00FF00", red: "FF0000", blue: "0000FF"}.each {|key, item| puts key.to_s + item.to_s}
# # [0,5,0,8].each {|item| puts item}
# # (1..10).each {|item| puts item}
# # #Tests my_each_with_index
# # puts "my_each_with_index"
# # [0,5,0,8].my_each_with_index {|item,index| puts item.to_s + " " +index.to_s}
# # (1..10).my_each_with_index {|item,index| puts item.to_s + " " + index.to_s}
# # puts "each_with_index"
# # [0,5,0,8].each_with_index {|item,index| puts item.to_s + " " +index.to_s}
# # (1..10).each_with_index {|item,index| puts item.to_s + " " + index.to_s}
# #Tests my_select
# # puts "my_select"
# # a = {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.my_select {|key,value| value.size > 4}
# # puts a
# # b =  [0,5,0,8].my_select {|number| number > 2}
# # puts b
# # c =  (1..100).my_select {|number| number % (number**0.5) == 0  }
# # puts c
# # puts "select"
# # a =  {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.select {|key,value| value.size > 4}
# # puts a
# # b =  [0,5,0,8].select {|number| number > 2}
# # puts b
# # c = (1..100).select {|number| number % (number**0.5) == 0  }
# # puts c
# # puts "my_all?"
# #  #{green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.my_each {|key , value| puts key.to_s + ": " + value}
# # #puts "next"
# # a = {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.my_all? {|key , value| value.size > 4}
# # puts a
# # a = {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.my_all? {|key , value| value.size > 0}
# # puts a
# # a = [0,1,3,4,5,8].my_all? {|item| item > 2}
# # puts a
# # a = [3,4,5,8].my_all? {|item| item > 2}
# # puts a
# # a = (0..10).my_all? {|item| item > 2}
# # puts a
# # a = (3..10).my_all? {|item| item > 2}
# # puts a
# #
# # puts "all?"
# # a =  {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.all? {|key , value| value.size > 4}
# # puts a
# # a = {green: "00FF00", red: "FF0000", blue: "0000FF", black: "0" }.all? {|key , value| value.size > 0}
# # puts a
# # a = [0,1,3,4,5,8].all? {|item| item > 2}
# # puts a
# # a = [3,4,5,8].all? {|item| item > 2}
# # puts a
# # a = (0..10).all? {|item| item > 2}
# # puts a
# # a = (3..10).all? {|item| item > 2}
# # puts a
# puts ([0,2,3].my_all?)
# puts ([false,true,true].my_all?)
