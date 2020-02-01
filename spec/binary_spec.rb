require './lib/search_tree.rb'

RSpec.describe 'BinaryTree' do

  tree = BinaryTree.new
  tree.new_node(tree.root, 3, '3', 'three')
  tree.new_node(tree.root, 6, '6', 'six')
  tree.new_node(tree.root, 10, '10', 'ten')
  tree.new_node(tree.root, 9, '9', 'nine')
  tree.new_node(tree.root, 2, '2', 'two')
  tree.new_node(tree.root, 5, '5', 'five')
  tree.new_node(tree.root, 8, '8', 'eight')
  tree.new_node(tree.root, 1, '1', 'one')
  tree.new_node(tree.root, 4, '4', 'four')
  tree.new_node(tree.root, 7, '7', 'seven')
  tree.new_node(tree.root, 0, '0', 'zero')

  describe 'Binary tree' do

    it 'return true to a node that was added in the tree' do
      expect(tree.search(3)).to be_truthy
    end

    it 'return false to a node that was not added in the tree' do
      expect(tree.search(11)).to be_falsy
    end

    it 'return the number of nodes in the tree' do
      expect(tree.number_nodes).to eql(11)
    end

    it 'return the depth of the tree' do
      expect(tree.get_depth).to eql(6)
    end

    it 'return the depth of the east branch' do
      expect(tree.get_depth(tree.root.east)).to eql(5)
    end

    it 'return the depth of the west branch' do
      expect(tree.get_depth(tree.root.west)).to eql(3)
    end

    it 'return false for a not-balanced tree' do
      expect(tree.balanced?).to be_falsy
    end

    it 'return true for a balanced tree' do
      tree.balance
      expect(tree.balanced?).to be_truthy
    end

    it 'return the depth of the tree' do
      expect(tree.get_depth).to eql(4)
    end

    it 'return the number of nodes in the tree' do
      expect(tree.number_nodes).to eql(11)
    end

    it 'return false to a node that was removed from the tree' do
      tree.delete_node(5)
      expect(tree.search(5)).to be_falsy
    end

    it 'return the number of nodes in the tree' do
      expect(tree.number_nodes).to eql(10)
    end

    it 'return true for a balanced tree' do
      expect(tree.balanced?).to be_truthy
    end

    it 'return the arguments of node 1' do
      expect(tree.search_node(1).args[0]).to eql('1')
      expect(tree.search_node(1).args[1]).to eql('one')
    end

    it 'return the arguments of node 1 after the change' do
      tree.edit_node(1, '01', 'zero one')
      expect(tree.search_node(1).args[0]).to eql('01')
      expect(tree.search_node(1).args[1]).to eql('zero one')
    end
  end
end