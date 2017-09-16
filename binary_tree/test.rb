require './Node.rb'
n = build_tree([0,3,4,5,8])
m = build_tree([3,1,10,100,2,0,12,24, 4])

p n
p m

# puts "search for 100"
# puts breadth_first_search(m, 100)
# puts "search for 15"
# puts breadth_first_search(m, 15)
# puts "search for 1"
# puts breadth_first_search(m, 1)

puts "search for 100"
puts depth_first_search(m, 100)
puts "search for 15"
puts depth_first_search(m, 15)
puts "search for 1"
puts depth_first_search(m, 1)

puts "search for 100"
puts m.dfs_rec(100)
puts "search for 15"
puts m.dfs_rec(15)
puts "search for 1"
puts m.dfs_rec(1)
