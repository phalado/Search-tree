require './lib/binary-tree-access.rb'

t = BinaryTree.new
# t.new_node(t.root, 3, '3', 'three')
# t.new_node(t.root, 6, '6', 'six')
# t.new_node(t.root, 10, '10', 'ten')
# t.new_node(t.root, 9, '9', 'nine')
# t.new_node(t.root, 2, '2', 'two')
# t.new_node(t.root, 5, '5', 'five')
# t.new_node(t.root, 8, '8', 'eight')
# t.new_node(t.root, 1, '1', 'one')
# t.new_node(t.root, 4, '4', 'four')
# t.new_node(t.root, 7, '7', 'seven')
# t.new_node(t.root, 0, '0', 'zero')
# p t.search(7)
# p t.search(5)
# p t.search(11)
# t.print_tree
# p t.number_nodes
# p t.get_depth
# p t.is_balanced?
# p t.get_depth(t.root.east.east)
# p t.get_depth(t.root.west)
# p "balance"
# t.balance
# p t.is_balanced?
# p t.get_depth
# t.delete_node(5)
# t.print_tree
# p t.is_balanced?
# t.delete_node(9)
# t.print_tree
# p t.is_balanced?
# p t.search_node(1).args
# t.edit_node(1, '01', 'zero one')
# p t.search_node(1).args
t.load_file('test_file')
p t.print_tree
t.save_file