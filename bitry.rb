require './lib/search_tree.rb'

t = BiDimensionalTree.new
t.new_node(t.root, 0, 0, '0 0', 'zero zero')
t.new_node(t.root, 2, 0, '2 0', 'two zero')
t.new_node(t.root, 0, 2, '0 2', 'zero two')
t.new_node(t.root, -2, 0, '-2 0', 'minus-two zero')
t.new_node(t.root, 0, -2, '0 -2', 'zero minus-two')
t.new_node(t.root, 0, 1, '0 1', 'zero one')
t.new_node(t.root, 0, 3, '0 3', 'zero three')
t.new_node(t.root, 0, -1, '0 -1', 'zero minus-one')
t.new_node(t.root, 0, -3, '0 -3', 'zero minus-three')
t.new_node(t.root, -2, 1, '-2 1', 'minus-two one')
t.new_node(t.root, -2, -1, '-2 -1', 'minus-two minus-one')
t.new_node(t.root, -3, 0, '-3 0', 'minus-three zero')
t.new_node(t.root, -1, 0, '-1 0', 'minus-one zero')
t.new_node(t.root, 2, 1, '2 1', 'two one')
t.new_node(t.root, 2, -1, '2 -1', 'two minus-one')
t.new_node(t.root, 3, 0, '3 0', 'three zero')
t.new_node(t.root, 4, 0, '4 0', 'four zero')
t.new_node(t.root, 1, 0, '1 0', 'one zero')
puts ''

# puts "#{t.root.x} #{t.root.y}"
# puts "#{t.root.east.x} #{t.root.east.y}"
# puts "#{t.root.west.x} #{t.root.west.y}"
# puts "#{t.root.north.x} #{t.root.north.y}"
# puts "#{t.root.south.x} #{t.root.south.y}"

puts 'Printing the tree'
t.print_tree
puts ''

# Expected true
print 'Is the node (2, 1) in the tree? '
puts t.search(2, 1)
puts ''

# Expected false
print 'Is the node (2, 2) in the tree? '
puts t.search(2, 2)
puts ''

# Expected ["2 1" "two one"]
print 'Arguments of the node (2, 1): '
p t.search_node(2, 1).args
puts ''

# Expected ["02 01" "zero-two zero-one"]
t.edit_node(2, 1, '02 01', 'zero-two zero-one')
print 'Arguments of node (2, 1) after change: '
p t.search_node(2, 1).args
puts ''

# Expected 4
print 'Max depth horizontal: '
puts t.get_depth_horiz
puts ''

# Expected 3
print 'Max depth vertical: '
puts t.get_depth_vert
puts ''

# Expected 8
print 'Number nodes hotizontal: '
puts t.number_nodes_horiz
puts ''

# Expected 7
print 'Number nodes vertical: '
puts t.number_nodes_vert
puts ''

# Expected 18
print 'Number nodes total: '
puts t.number_nodes_total
puts ''

t.new_node(t.root, 5, 0, '5 0', 'five zero')
puts ''

# Expected false
print 'Is the tree balanced in the horizontal? '
puts t.balanced_horiz?
puts ''

# Expected true
print 'Is the tree balanced in the vertical? '
puts t.balanced_vert?
puts ''

t.new_node(t.root, -2, 2, '-2 2', 'minus-two two')
t.new_node(t.root, -2, 3, '-2 3', 'minus-two three')
puts ''

# Expected false
print 'Is the tree balanced in the vertical? '
puts t.balanced_vert?
puts ''

puts 'Balancing in the vertical'
t.balance_vert
puts ''

# Expected true
print 'Is the tree balanced in the vertical? '
puts t.balanced_vert?
puts ''

# Expected 21
print 'Number nodes total: '
puts t.number_nodes_total
puts ''

puts 'Balancing in the horizontal'
t.balance_horiz
puts ''

# Expected false
print 'Is the tree balanced in the horizontal? '
puts t.balanced_horiz?
puts ''

puts 'Deleting node (4, 0): '
t.delete_node(4, 0)
puts ''

# Expected 20
print 'Number nodes total: '
puts t.number_nodes_total
puts ''


puts 'Deleting node (0, 3): '
t.delete_node(0, 3)
puts ''

# Expected 19
print 'Number nodes total: '
puts t.number_nodes_total
puts ''
