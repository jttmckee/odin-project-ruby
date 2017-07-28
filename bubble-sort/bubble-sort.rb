def bubble_sort list
iterations = 0
new_list = list
swapped = true
counter = 1
  while swapped == true && (counter < list.length)
    swapped = false
    counter += 1
    new_list[0..(new_list.length-counter)].each_index do |index|
      iterations += 1
      if new_list[index] > new_list[index+1]
        item = new_list[index]
        new_list[index] = new_list[index+1]
        new_list[index+1] = item
        swapped = true
      end
    end
  end
  puts "This took #{iterations} iterations"
  return new_list
end

puts bubble_sort([4,3,78,2,0,2])
puts bubble_sort([0, 4,3,2,2, 78])
puts bubble_sort([0, 4,3,2,2, 78].reverse)
