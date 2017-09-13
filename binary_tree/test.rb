require './Node.rb'
n = build_tree([0,3,4,5,8])
m = build_tree([3,1,10,100,2,0,12,24, 4])

p n
p m

p breadth_first_search(m, 100)
p breadth_first_search(m, 15)
p breadth_first_search(m, 1)
