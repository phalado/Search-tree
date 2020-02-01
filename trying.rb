require './lib/search_tree.rb'

t = BinaryTree.new
t.new_node(t.root, 3, '3', 'three')
t.new_node(t.root, 6, '6', 'six')
t.new_node(t.root, 10, '10', 'ten')
t.new_node(t.root, 9, '9', 'nine')
t.new_node(t.root, 2, '2', 'two')
t.new_node(t.root, 5, '5', 'five')
t.new_node(t.root, 8, '8', 'eight')
t.new_node(t.root, 1, '1', 'one')
t.new_node(t.root, 4, '4', 'four')
t.new_node(t.root, 7, '7', 'seven')
t.new_node(t.root, 0, '0', 'zero')

# Expected true
print "Is 7 on the tree? "
puts t.search(7)

# Expected true
print "Is 5 on the tree? "
puts t.search(5)

# Expected false
print "Is 11 on the tree? "
puts t.search(11)
puts ''

puts "Print the tree "
t.print_tree
puts ''

# Expected 11
print "How many nodes are in the tree? "
puts t.number_nodes
puts ''

# Expected 6
print "What is the depth "
puts t.get_depth
puts ''

# Expected false
print "Is the tree balanced? "
puts t.balanced?
puts ''

# Expected 5
print "Depth of east east "
puts t.get_depth(t.root.east.east)
puts ''

# Expected 3
print "Depth of west "
puts t.get_depth(t.root.west)
puts ''

puts "Balancing the tree "
t.balance
puts ''

# Expected true
print "Is the tree balanced? "
puts t.balanced?
puts ''

# Expected 4
print "What is the depth "
puts t.get_depth
puts ''

t.delete_node(5)
puts "Deleting node 5"
puts ''

puts "Print the tree "
t.print_tree
puts ''

# Expected true
print "Is the tree balanced? "
puts t.balanced?
puts ''

t.delete_node(9)
puts "Deleting node 9"
puts ''

puts "Print the tree "
t.print_tree
puts ''

# Expected 9
print "Number of nodes: "
puts t.number_nodes
puts ''

# Expected true
print "Is the tree balanced? "
puts t.balanced?
puts ''

# Expected '["1", "one"]'
print "Arguments of node 1 before change: "
p t.search_node(1).args
puts ''

# Expected '["01", "zero one"]'
t.edit_node(1, '01', 'zero one')
print "Arguments of node 1 after change: "
p t.search_node(1).args
puts ''

tree = BinaryTree.new

puts "Loading file 'test_file'"
tree.load_file('test_file')
puts ''

puts "Printing the new tree"
puts tree.print_tree
puts ''

t.save_file
