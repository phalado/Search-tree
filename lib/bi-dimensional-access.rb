class BiDimensionalTree
  attr_reader :root

  # Initialize the tree creating it's root
  def initialize
    @root = nil
  end

  # Create a new branch after locating it's place
  def new_node(node, x, y, *args)
    if @root.nil?
      puts "Adding the node (#{x}, #{y}) in the root"
      return @root = BiNode.new(x, y, *args)
    elsif node.nil?
      return node = BiNode.new(x, y, *args)
    elsif node.x == x
      if node.y == y
        return node
      elsif y < node.y
        if node.south.nil?
          puts "Adding the node (#{x}, #{y}) in the south of (#{node.x}, #{node.y})"
          node.south = new_node(node.south, x, y, *args)
        else
          new_node(node.south, x, y, *args)
        end
      elsif y > node.y
        if node.north.nil?
          puts "Adding the node (#{x}, #{y}) in the north of (#{node.x}, #{node.y})"
          node.north = new_node(node.north, x, y, *args)
        else
          new_node(node.north, x, y, *args)
        end
      end
    elsif x < node.x
      if node.west.nil?
        puts "Adding the node (#{x}, #{y}) in the west of (#{node.x}, #{node.y})"
        node.west = new_node(node.west, x, y, *args)
      else
        new_node(node.west, x, y, *args)
      end
    elsif x > node.x
      if node.east.nil?
        puts "Adding the node (#{x}, #{y}) in the east of (#{node.x}, #{node.y})"
        node.east = new_node(node.east, x, y, *args)
      else
        new_node(node.east, x, y, *args)
      end
    end
  end

  # Create a new node and balance the tree
  def new_node_balanced(node, x, y, *args)
    new_node(node, x, y, *args)
    balance
  end

  # Locate a branch, if it exists
  def search(x, y, node = @root)
    return false if node.nil?

    if x == node.x
      if y == node.y
        return true
      elsif y < node.y and !node.south.nil?
        search(x, y, node.south)
      elsif y > node.y and !node.north.nil?
        search(x, y, node.north)
      else
        return false
      end
    elsif x < node.x and !node.west.nil?
      search(x, y, node.west)
    elsif x > node.x and !node.east.nil?
      search(x, y, node.east)
    else
      return false
    end
  end

  # Locate a branch, if it exists
  def search_node(x, y, node = @root)
    return nil if node.nil?

    if x == node.x
      if y == node.y
        return node
      elsif y < node.y and !node.south.nil?
        search_node(x, y, node.south)
      elsif y > node.y and !node.north.nil?
        search_node(x, y, node.north)
      else
        return nil
      end
    elsif x < node.x and !node.west.nil?
      search_node(x, y, node.west)
    elsif x > node.x and !node.east.nil?
      search_node(x, y, node.east)
    else
      return nil
    end
  end

  # Edit an existing node
  def edit_node(x, y, *args)
    node = search_node(x, y)
    return if node.nil?
    node.args = args
  end

  # Load a file and create a (sub)tree with its data
  def load_file(file)
    data = File.open(file).readlines.map(&:chomp)
    data.each do |d|
      d = d.split(',')
      new_node(@root, *d[0], *d[1], *d[2..-1]) unless d.nil?
    end
  end

  # Save the current tree in a file
  def save_file
    nodes = get_nodes([])
    file = File.open('search_tree', 'w')
    nodes.each do |node|
        file.puts("#{node.x} #{node.y} #{node.args}")
    end
    file.close
  end

  # Print all the branchs
  def print_tree(node = @root)
    return if node.nil?
    print_tree(node.west) unless node.west.nil?
    print_tree(node.south) unless node.south.nil?
    puts "#{node.x} #{node.y} #{node.args}"
    print_tree(node.north) unless node.north.nil?
    print_tree(node.east) unless node.east.nil?
    return
  end

  # Delete a selected node from the tree
  def delete_node(x, y)
    node = search_node(x, y)
    nodes = get_nodes_horiz([])
    if nodes.include? node
      nodes.delete(node)
      @root = nodes[nodes.length / 2]
      @root.west = nil
      @root.east = nil

      @root.west = new_balance_nodes_horiz(nodes[0..(nodes.length / 2) - 1])
      @root.east = new_balance_nodes_horiz(nodes[(nodes.length / 2) + 1..-1])
    else
      nodes = get_column(node)
      nodes.delete(node)
      middle = nodes[nodes.length / 2]
      middle.south = nil
      middle.north = nil

      middle.south = new_balance_nodes_vert(nodes[0..(nodes.length / 2) - 1])
      middle.north = new_balance_nodes_vert(nodes[(nodes.length / 2) + 1..-1])
    end
  end

  # Balance the tree
  def balance_vert(node = @root)
    unless balanced_vert_helper(node)
      balance_vert_helper(node, node)
    end
    unless node.east.nil?
      unless balanced_vert_helper(node.east)
        node.east = balance_vert_helper(node.east, node.east)
      else
        balance_vert(node.east)
      end
    end
    unless node.west.nil?
      unless balanced_vert_helper(node.west)
        node.west = balance_vert_helper(node.west, node.west)
      else
        balance_vert(node.west)
      end
    end
  end

  def balance_horiz(node = @root)
    return if balanced_horiz?

    nodes = get_nodes_horiz([], node)

    @root = nodes[nodes.length / 2]
    @root.west = nil
    @root.east = nil

    @root.west = new_balance_nodes_horiz(nodes[0..(nodes.length / 2) - 1])
    @root.east = new_balance_nodes_horiz(nodes[(nodes.length / 2) + 1..-1])
  end

  # Return true if tree is balanced, in other word,
  # if the number of branchs is smaller than 2 raised
  # to the tree's depth
  def balanced_horiz?
    number_nodes_horiz.between?(2**(get_depth_horiz - 1), 2**get_depth_horiz)
  end

  def balanced_vert?(node = @root)
    return false unless balanced_vert_helper(node)
    unless node.east.nil?
      return false unless balanced_vert?(node.east)
    end
    unless node.west.nil?
      return false unless balanced_vert?(node.west)
    end
    true
  end

  def balance
    balance_horiz unless balanced_horiz?
    balance_vert unless balanced_vert?
  end

  def balanced_tree
    return false unless balanced_horiz?
    return false unless balanced_vert?
    true
  end

  # Return the max depth of the tree
  def get_depth_horiz(node = @root, depth = 1, maxdepth = 0)
    unless node.west.nil?
      maxdepth = get_depth_horiz(node.west, depth + 1, maxdepth)
    end

    unless node.east.nil?
      maxdepth = get_depth_horiz(node.east, depth + 1, maxdepth)
    end

    if node.west.nil? and node.east.nil? and depth > maxdepth
      maxdepth = depth
    end

    maxdepth
  end

  def get_depth_vert(node = @root, depth = 1, maxdepth = 0)
    unless node.south.nil?
      maxdepth = get_depth_vert(node.south, depth + 1, maxdepth)
    end

    unless node.north.nil?
      maxdepth = get_depth_vert(node.north, depth + 1, maxdepth)
    end

    if node.south.nil? and node.north.nil? and depth > maxdepth
      maxdepth = depth
    end

    maxdepth
  end

  # Return the number of branchs
  def number_nodes_horiz(node = @root)
    if node.nil?
      0
    else
      1 +
      number_nodes_horiz(node.west) +
      number_nodes_horiz(node.east)
    end
  end

  def number_nodes_vert(node = @root)
    if node.nil?
      0
    else
      1 +
      number_nodes_vert(node.south) +
      number_nodes_vert(node.north)
    end
  end

  def number_nodes_total(node = @root)
    if node.nil?
      0
    else
      1 +
      number_nodes_total(node.west)  +
      number_nodes_total(node.east)  +
      number_nodes_total(node.south) +
      number_nodes_total(node.north)
    end
  end

  private

  # Return all the nodes in crescent order
  def get_nodes_horiz(nodes, node = @root)
    nodes = get_nodes_horiz(nodes, node.west) unless node.west.nil?
    nodes << node
    nodes = get_nodes_horiz(nodes, node.east) unless node.east.nil?
    return nodes
  end

  def new_balance_nodes_horiz(nodes)
    return nil if nodes.empty?

    new_middle = nodes[nodes.length / 2]
    new_middle.east = nil
    new_middle.west = nil

    return new_middle if nodes.length == 1

    new_middle.west = new_balance_nodes_horiz(nodes[0..(nodes.length / 2) - 1])
    new_middle.east = new_balance_nodes_horiz(nodes[(nodes.length / 2) + 1..-1])

    return new_middle
  end

  def get_nodes_vert(nodes, node = @root)
    nodes = get_nodes_vert(nodes, node.south) unless node.south.nil?
    nodes << node
    nodes = get_nodes_vert(nodes, node.north) unless node.north.nil?
    return nodes
  end

  def balance_vert_helper(node, partial_root)
    nodes = get_nodes_vert([], node)

    middle = nodes[nodes.length / 2]
    if partial_root.east
      middle.east = partial_root.east
      partial_root.east = nil
    end
    if partial_root.west
      middle.west = partial_root.west
      partial_root.west = nil
    end
    middle.north = nil
    middle.south = nil

    middle.south = new_balance_nodes_vert(nodes[0..(nodes.length / 2) - 1])
    middle.north = new_balance_nodes_vert(nodes[(nodes.length / 2) + 1..-1])

    return middle
  end

  def new_balance_nodes_vert(nodes)
    return nil if nodes.empty?

    new_middle = nodes[nodes.length / 2]
    new_middle.north = nil
    new_middle.south = nil

    return new_middle if nodes.length == 1

    new_middle.south = new_balance_nodes_vert(nodes[0..(nodes.length / 2) - 1])
    new_middle.north = new_balance_nodes_vert(nodes[(nodes.length / 2) + 1..-1])

    return new_middle
  end

  def balanced_vert_helper(node)
    number_nodes_vert(node).between?(2**(get_depth_vert(node) - 1), 2**get_depth_vert(node))
  end

  def get_column(node, middle = @root)
    return [] if middle.nil?
    nodes = get_nodes_vert([], middle)
    return nodes if nodes.include? node
    nodes = get_column(node, middle.west) unless middle.west.nil?
    return nodes if nodes.include? node
    nodes = get_column(node, middle.east) unless middle.east.nil?
    return nodes if nodes.include? node
    return []
  end
end
