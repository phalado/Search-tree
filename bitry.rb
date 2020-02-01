require './lib/bi-dimensional-access.rb'

t = BiDimensionalTree.new
t.new_node(t.root, 3, 1, '3', 'three')
t.new_node(t.root, 3, 3, '3', 'three')
t.new_node(t.root, 3, 6, '3', 'three')
t.new_node(t.root, 3, 10, '3', 'three')
t.new_node(t.root, 3, 2, '3', 'three')
t.new_node(t.root, 3, 11, '3', 'three')
t.new_node(t.root, 6, 0, '6', 'six')
t.new_node(t.root, 10, 0, '10', 'ten')
t.new_node(t.root, 9, 0, '9', 'nine')
t.new_node(t.root, 2, 0, '2', 'two')
t.print_tree
p t.search(3, 6)
p t.search(6, 1)
