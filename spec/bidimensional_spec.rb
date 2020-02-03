require './lib/search_tree.rb'

RSpec.describe 'BiDimensionalTree' do

  tree = BiDimensionalTree.new
  tree.new_node(tree.root, 0, 0, '0 0', 'zero zero')
  tree.new_node(tree.root, 2, 0, '2 0', 'two zero')
  tree.new_node(tree.root, 0, 2, '0 2', 'zero two')
  tree.new_node(tree.root, -2, 0, '-2 0', 'minus-two zero')
  tree.new_node(tree.root, 0, -2, '0 -2', 'zero minus-two')
  tree.new_node(tree.root, 0, 1, '0 1', 'zero one')
  tree.new_node(tree.root, 0, 3, '0 3', 'zero three')
  tree.new_node(tree.root, 0, -1, '0 -1', 'zero minus-one')
  tree.new_node(tree.root, 0, -3, '0 -3', 'zero minus-three')
  tree.new_node(tree.root, -2, 1, '-2 1', 'minus-two one')
  tree.new_node(tree.root, -2, -1, '-2 -1', 'minus-two minus-one')
  tree.new_node(tree.root, -3, 0, '-3 0', 'minus-three zero')
  tree.new_node(tree.root, -1, 0, '-1 0', 'minus-one zero')
  tree.new_node(tree.root, 2, 1, '2 1', 'two one')
  tree.new_node(tree.root, 2, -1, '2 -1', 'two minus-one')
  tree.new_node(tree.root, 3, 0, '3 0', 'three zero')
  tree.new_node(tree.root, 4, 0, '4 0', 'four zero')
  tree.new_node(tree.root, 1, 0, '1 0', 'one zero')
  tree.new_node(tree.root, 5, 0, '5 0', 'five zero')

  describe 'Bi Dimensional Tree' do

    it 'return true to a node that is on the tree' do
      expect(tree.search(2, 1)).to be_truthy
    end

    it 'return false to a node that is not on the tree' do
      expect(tree.search(2, 2)).to be_falsy
    end

    it 'return the arguments of a node' do
      expect(tree.search_node(2, 1).args).to eql(["2 1", "two one"])
    end

    it 'return the arguments of a node after changing then' do
      tree.edit_node(2, 1, '02 01', 'zero-two zero-one')
      expect(tree.search_node(2, 1).args).to eql(["02 01", "zero-two zero-one"])
    end

    it 'return the max depth in the horizontal of the tree' do
      expect(tree.get_depth_horiz).to eql(5)
    end

    it 'return the max depth in the vertical of the tree' do
      expect(tree.get_depth_vert).to eql(3)
    end

    it 'return the number of nodes in the horizontal of the tree' do
      expect(tree.number_nodes_horiz).to eql(9)
    end

    it 'return the number of nodes in the vertical of the tree' do
      expect(tree.number_nodes_vert).to eql(7)
    end

    it 'return the total number of nodes in the tree' do
      expect(tree.number_nodes_total).to eql(19)
    end

    it 'return true for a balanced tree in the vertical' do
      expect(tree.balanced_vert?).to be_truthy
    end


    it 'return false for a balanced tree in the vertical' do
      tree.new_node(tree.root, -2, 2, '-2 2', 'minus-two two')
      tree.new_node(tree.root, -2, 3, '-2 3', 'minus-two three')
      expect(tree.balanced_vert?).to be_falsy
    end

    it 'return true for a balanced tree in the vertical' do
      tree.balance_vert
      expect(tree.balanced_vert?).to be_truthy
    end

    it 'return the total number of nodes in the tree' do
      expect(tree.number_nodes_total).to eql(21)
    end

    it 'return false for a balanced tree in the horizontal and general' do
      expect(tree.balanced_horiz?).to be_falsy
      expect(tree.balanced_tree).to be_falsy
    end

    it 'return true for a balanced tree in the horizontal and general' do
      tree.balance_horiz
      expect(tree.balanced_horiz?).to be_truthy
      expect(tree.balanced_tree).to be_truthy
    end

    it 'return true for the presence of a node, delete it and return false' do
      expect(tree.search(4, 0)).to be_truthy
      tree.delete_node(4, 0)
      expect(tree.search(4, 0)).to be_falsy
    end

    it 'return true for the presence of a node, delete it and return false' do
      expect(tree.search(0, 3)).to be_truthy
      tree.delete_node(0, 3)
      expect(tree.search(0, 3)).to be_falsy
    end

    it 'return the total number of nodes in the tree' do
      expect(tree.number_nodes_total).to eql(19)
    end

  end
end