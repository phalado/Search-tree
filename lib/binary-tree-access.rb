class BinaryTree
  attr_reader :root

  # Initialize the tree creating it's root
  def initialize
    @root = nil
  end

  # Create a new branch after locating it's place
  def new_node(node, x, *args)
    return @root = Node.new(x, *args) if @root.nil?
    return Node.new(x, *args) if node.nil?
    return node if node.x == x

    if x < node.x
      if node.west.nil?
        node.west = new_node(node.west, x, *args)
      else
        new_node(node.west, x, *args)
      end
    elsif node.east.nil?
      node.east = new_node(node.east, x, *args)
    else
      new_node(node.east, x, *args)
    end
  end

  # Create a new node and balance the tree
  def new_node_balanced(node, x, *args)
    new_node(node, x, *args)
    balance unless balanced?
  end

  # Edit an existing node
  def edit_node(x, *args)
    node = search_node(x)
    return if node.nil?
    node.args = args
  end

  # Load a file and create a (sub)tree with its data
  def load_file(file)
    data = File.open(file).readlines.map(&:chomp)
    data.each do |d|
      d = d.split(',')
      new_node(@root, *d[0], *d[1..-1]) unless d.nil?
    end
  end

  # Save the current tree in a file
  def save_file
    nodes = get_nodes([])
    file = File.open('search_tree', 'w')
    nodes.each do |node|
      file.puts("#{node.x} #{node.args}")
    end
    file.close
  end

  # Delete a selected node from the tree
  def delete_node(x)
    nodes = get_nodes([])
    (0...nodes.length).each do |i|
      if nodes[i].x == x.to_i
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

    if x == node.x
      return true
    elsif x < node.x && !node.west.nil?
      search(x, node.west)
    elsif x > node.x && !node.east.nil?
      search(x, node.east)
    else
      return false
    end
  end

  # Locate a branch, if it exists
  def search_node(x, node = @root)
    return nil if node.nil?

    if x == node.x
      return node
    elsif x < node.x && !node.west.nil?
      search_node(x, node.west)
    elsif x > node.x && !node.east.nil?
      search_node(x, node.east)
    else
      return nil
    end
  end

  # Print all the branchs
  def print_tree(node = @root)
    return if node.nil?
    print_tree(node.west) unless node.west.nil?
    puts "#{node.x} #{node.args}"
    print_tree(node.east) unless node.east.nil?
  end

  # Return all the nodes in crescent order
  def get_nodes(nodes, node = @root)
    nodes = get_nodes(nodes, node.west) unless node.west.nil?
    nodes << node
    nodes = get_nodes(nodes, node.east) unless node.east.nil?
    nodes
  end

  # Balance the tree
  def balance
    unless balanced?
      nodes = get_nodes([])
      @root = nil
      new_balance_nodes(nodes, @root)
    end
  end

  def new_balance_nodes(nodes, newroot = @root)
    # p nodes
    return if nodes.empty?
    new_node(newroot, nodes[nodes.length / 2].x, *nodes[nodes.length / 2].args)
    return if nodes.length == 1
    new_balance_nodes(nodes[0..(nodes.length / 2) - 1], @root)
    new_balance_nodes(nodes[(nodes.length / 2) + 1..-1], @root)
  end

  # Return true if tree is balanced, in other word,
  # if the number of branchs is smaller than 2 raised
  # to the tree's depth
  def balanced?
    number_nodes.between?(2**(get_depth - 1), 2**get_depth)
  end

  # Return the max depth of the tree
  def get_depth(node = @root, depth = 1, maxdepth = 0)
    maxdepth = get_depth(node.west, depth + 1, maxdepth) unless node.west.nil?
    maxdepth = get_depth(node.east, depth + 1, maxdepth) unless node.east.nil?
    maxdepth = depth if node.west.nil? && node.east.nil? && depth > maxdepth

    maxdepth
  end

  # Return the number of branchs
  def number_nodes(node = @root)
    node.nil? ? 0 : 1 + number_nodes(node.west) + number_nodes(node.east)
  end
end
