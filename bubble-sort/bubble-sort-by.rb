def bubble_sort_by list
iterations = 0
new_list = list
swapped = true
counter = 1
  while swapped == true && (counter < list.length)
    swapped = false
    counter += 1
    new_list[0..(new_list.length-counter)].each_index do |index|
      iterations += 1
      if yield(new_list[index] , new_list[index+1]) == 1
        item = new_list[index]
        new_list[index] = new_list[index+1]
        new_list[index+1] = item
        swapped = true
      end
    end
  end
  #puts "This took #{iterations} iterations"
  return new_list
end

#puts bubble_sort_by([4,3,78,2,0,2]) {|a,b| a <=> b}
#puts bubble_sort_by([0, 4,3,2,2, 78]) {|a,b| a <=> b}
#puts bubble_sort_by([0, 4,3,2,2, 78].reverse) {|a,b| a <=> b}

a = bubble_sort_by(["hi","hello","hey"]) do |left,right|
   left.length - right.length
end
puts a
