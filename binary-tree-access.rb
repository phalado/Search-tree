require './binary-tree-node.rb'

class SearchTree
  attr_accessor :root

  # Initialize the tree creating it's root
  def initialize
    @root = nil
  end

  # Create a new branch after locating it's place
  def new_node(node, x, *args)
    return @root = Node.new(x.to_s, *args) if @root.nil?
    if node.nil?
      return node = Node.new(x.to_s, *args)
    elsif node.x == x.to_s
      return node
    elsif x.to_s < node.x
      if node.left.nil?
        node.left = new_node(node.left, x, *args)
      else
        new_node(node.left, x, *args)
      end
    elsif x.to_s > node.x
      if node.right.nil?
        node.right = new_node(node.right, x, *args)
      else
        new_node(node.right, x, *args)
      end
    end
  end

  def new_node_balanced(node, x, *args)
    new_node(node, x, *args)
    balance unless is_balanced?
  end

  def edit_node(x, *args)
    node = search_node(x)
    return if node.nil?
    node.args = args
  end

  def load_file
  end

  def save_file
  end

  # Delete a selected node from the tree
  def delete_node(x)
    nodes = get_nodes([])
    for i in (0...nodes.length)
      if nodes[i].x == x.to_s
        nodes.slice!(i)
        break
      end
    end
    @root = nil
    new_balance_nodes(nodes, @root)
  end

  # Locate a branch, if it exists
  def search(x, node = @root)
    return false if node.nil?

    if x.to_s == node.x
      return true
    elsif x.to_s < node.x and node.left != nil
      search(x, node.left)
    elsif x.to_s > node.x and node.right != nil
      search(x, node.right)
    else
      return false
    end
  end

  # Locate a branch, if it exists
  def search_node(x, node = @root)
    return nil if node.nil?

    if x.to_s == node.x
      return node
    elsif x.to_s < node.x and node.left != nil
      search_node(x, node.left)
    elsif x.to_s > node.x and node.right != nil
      search_node(x, node.right)
    else
      return nil
    end
  end

  # Print all the branchs
  def print_tree(node = @root)
    print_tree(node.left) unless node.left.nil?
    puts "#{node.x} #{node.args}"
    print_tree(node.right) unless node.right.nil?
    return
  end

  # Return all the nodes in crescent order
  def get_nodes(nodes, node = @root)
    nodes = get_nodes(nodes, node.left) unless node.left.nil?
    nodes << node
    nodes = get_nodes(nodes, node.right) unless node.right.nil?
    return nodes
  end

  # Balance the tree
  def balance
    unless is_balanced?
      nodes = get_nodes([])
      @root = nil
      new_balance_nodes(nodes, @root)
    end
  end

  def new_balance_nodes(nodes, newroot = @root)
    # p nodes
    return if nodes.length < 1
    new_node(newroot, nodes[nodes.length / 2].x, *nodes[nodes.length / 2].args)
    return if nodes.length == 1
    new_balance_nodes(nodes[0..(nodes.length / 2) - 1], @root)
    new_balance_nodes(nodes[(nodes.length / 2) + 1..-1], @root)
  end

  # Return true if tree is balanced, in other word,
  # if the number of branchs is smaller than 2 raised
  # to the tree's depth
  def is_balanced?
    return number_nodes.between?(2 ** (get_depth - 1), 2 ** get_depth)
  end

  # Return the max depth of the tree
  def get_depth(node = @root, depth = 1, maxdepth = 0)
    unless node.left.nil?
      maxdepth = get_depth(node.left, depth + 1, maxdepth)
    end

    unless node.right.nil?
      maxdepth = get_depth(node.right, depth + 1, maxdepth)
    end

    if node.right.nil? and node.left.nil? and
                           depth > maxdepth
      maxdepth = depth
    end

    return maxdepth
  end

  # Return the number of branchs
  def number_nodes(node = @root)
    if node.nil?
      return 0
    else
      return 1 + number_nodes(node.left) +
                 number_nodes(node.right)
    end
  end
end