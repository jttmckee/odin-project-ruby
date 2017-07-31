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

  def my_any?
    unless block_given?
      return self.my_select { |obj| obj} != {}
    else
      test = self.my_select { |key,value| yield(key,value) } if self.class == Hash
      test = self.my_select { |item| yield(item) } if self.class == Array ||  self.class == Range
      return !(test.empty?)
    end
  end

  def my_none?
    return !(my_any? {|obj, obj1| yield(obj, obj1)})
  end

  def my_count(target=nil)
    unless block_given?
      if target == nil
        return self.size
      else
        return self.my_select {|item| item == target }.size
      end
    else
      test = self.my_select { |key,value| yield(key,value) } if self.class == Hash
      test = self.my_select { |item| yield(item) } if self.class == Array ||  self.class == Range
      return test.size
    end
  end

  def my_map(a_proc=nil)
    results = []
    unless a_proc && a_proc.class == Proc
      self.my_each { |item,item2| results << yield(item, item2)}
      return results
    else
      self.my_each { |item, item2| results << a_proc.call(item,item2)}
      return results
    end
  end

  def my_inject(startValue = nil)
    memo =  (startValue ?   startValue : self.first)

    self.my_each { |item| memo = yield(memo,item) } if self.class == Array || self.class == Range

    if self.class == Hash
      self.my_each { |key, value|
        object = key, value
        memo = yield(memo, object)

      }

    end

    return memo

  end

  def multiply_els
    return self.my_inject {|memo, item| memo*item} if self.class == Array || self.class == Range
    return self.values.multiply_els if self.class == Hash
  end



end

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
#Tests for my_any?
# puts "my_any?"
# puts ({white: "FFFFFF"}).my_any? { | key, value| value.size ===0 }
# puts ({white: "FFFFFF", uv: ""}).my_any? { | key, value| value.size ===0 }
# puts [0,1,2,3].my_any? {|item| item == 4 }
# puts [0,1,2,3].my_any? {|item| item <= 4}
# puts (0...10).my_any? { |item| item % 2 == 0 }
# puts (1...10).my_any? { |item| item % 13 == 0 }
#
# puts "any?"
# puts ({white: "FFFFFF"}).any? { | key, value| value.size ===0 }
# puts ({white: "FFFFFF", uv: ""}).any? { | key, value| value.size ===0 }
# puts [0,1,2,3].any? {|item| item == 4}
# puts [0,1,2,3].any? {|item| item <= 4}
# puts (0...10).any? { |item| item % 2 == 0 }
# puts (1...10).any? { |item| item % 13 == 0 }
#Tests for my_none?
# puts "my_none?"
# puts ({white: "FFFFFF"}).my_none? { | key, value| value.size ===0 }
# puts ({white: "FFFFFF", uv: ""}).my_none? { | key, value| value.size ===0 }
# puts [0,1,2,3].my_none? {|item| item == 4 }
# puts [0,1,2,3].my_none? {|item| item <= 4}
# puts (0...10).my_none? { |item| item % 2 == 0 }
# puts (1...10).my_none? { |item| item % 13 == 0 }
#
# puts "none?"
# puts ({white: "FFFFFF"}).none? { | key, value| value.size ===0 }
# puts ({white: "FFFFFF", uv: ""}).none? { | key, value| value.size ===0 }
# puts [0,1,2,3].none? {|item| item == 4}
# puts [0,1,2,3].none? {|item| item <= 4}
# puts (0...10).none? { |item| item % 2 == 0 }
# puts (1...10).none? { |item| item % 13 == 0 }
#Tests for my_count
# puts "my_count"
# puts ({dogs: 0, cats:2, fish:3}.my_count(2))
# puts ({apes: 0}.my_count)
# puts ({dogs: 0, cats:2, fish:3}.my_count {|key, value| value > 1})
# puts ([0,2,6,4,6,7].my_count(6))
# puts ([0,2,6,4,6,7].my_count {|value| value > 3})
# puts ((2..10).my_count{|number| number >= 4})
# puts "count"
# puts ({dogs: 0, cats:2, fish:3}.count(2))
# puts ({apes: 0}.count)
# puts ({dogs: 0, cats:2, fish:3}.count {|key, value| value > 1})
# puts ([0,2,6,4,6,7].count(6))
# puts ([0,2,6,4,6,7].count {|value| value > 3})
# puts ((2..10).count{|number| number >= 4})
# tests for my_map
# puts "my_map"
# puts({dogs:2, cats:3}.my_map { |key, value| value +=3 })
# puts([0,1,2,3,4].my_map {|number| number * 4})
# puts((2..10).my_map {|number| number * 4})
# # puts "map"
# # puts({dogs:2, cats:3}.map { |key, value| value +=3 })
# # puts([0,1,2,3,4].map {|number| number * 4})
# # puts((2..10).map {|number| number * 4})
# puts "my_map with proc"
# puts({dogs:2, cats:3}.my_map (Proc.new { |key, value| value +=3}))
# puts([0,1,2,3,4].my_map (Proc.new {|number| number * 4 }))
# puts((2..10).my_map (Proc.new {|number| number * 4}))

#Tests my_inject
# puts "my_inject"
# puts([0,1,2,3].my_inject {|memo, item| memo + item})
# puts([0,1,2,3].my_inject(10) {|memo, item| memo - item})
# puts ((1..10).my_inject {|memo, item| memo * item})
# puts  ({red: 0, blue: 2, green: 3}.inject({}) do |memo, obj|
#   key, value = obj
#   memo[key] = value if value >= 2
#   memo
# end
#   )
# puts "inject"
# puts([0,1,2,3].inject {|memo, item| memo + item})
# puts([0,1,2,3].inject(10) {|memo, item| memo - item})
# puts ((1..10).inject {|memo, item| memo * item})
# puts  ({red: 0, blue: 2, green: 3}.inject({}) do |memo, obj|
#   key, value = obj
#   memo[key] = value if value >= 2
#   memo
# end
#   )
#Test multiply_els
# puts "multiply_els"
# puts ([1,2,3].multiply_els)
# puts ((1..10).multiply_els)
# puts ({red: 2, green: 3, blue: 4}.multiply_els)
