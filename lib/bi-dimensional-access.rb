class BiDimensionalTree
  attr_reader :root

  # Initialize the tree creating it's root
  def initialize
    @root = nil
  end

  # Create a new branch after locating it's place
  def new_node(node, x, y, *args)
    return @root = Node.new(x, y, *args) if @root.nil?
    if node.nil?
      return node = Node.new(x, y, *args)
    elsif node.x == x
      if node.y == y
        return node
      elsif y < node.y
        if node.south.nil?
          node.south = new_node(node.south, x, y, *args)
        else
          new_node(node.south, x, y, *args)
        end
      elsif y > node.y
        if node.north.nil?
          node.north = new_node(node.north, x, y, *args)
        else
          new_node(node.north, x, y, *args)
        end
      end
    elsif x < node.x
      if node.west.nil?
        node.west = new_node(node.west, x, y, *args)
      else
        new_node(node.west, x, y, *args)
      end
    elsif x > node.x
      if node.east.nil?
        node.east = new_node(node.east, x, y, *args)
      else
        new_node(node.east, x, y, *args)
      end
    end
  end

  # Create a new node and balance the tree
  def new_node_balanced(node, x, y, *args)
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
    return false if node.nil?

    if x == node.x
      if y == node.y
        return node
      elsif y < node.y and !node.south.nil?
        search(x, y, node.south)
      elsif y > node.y and !node.north.nil?
        search(x, y, node.north)
      else
        return nil
      end
    elsif x < node.x and !node.west.nil?
      search(x, y, node.west)
    elsif x > node.x and !node.east.nil?
      search(x, y, node.east)
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

  # Return all the nodes in crescent order
  def get_nodes_horiz(nodes, node = @root)
    nodes = get_nodes(nodes, node.west) unless node.west.nil?
    nodes << node
    nodes = get_nodes(nodes, node.east) unless node.east.nil?
    return nodes
  end

  def get_nodes_vert(nodes, node = @root)
    nodes = get_nodes(nodes, node.south) unless node.south.nil?
    nodes << node
    nodes = get_nodes(nodes, node.north) unless node.north.nil?
    return nodes
  end

  # Delete a selected node from the tree
  def delete_node(x, y)
  end

  # Balance the tree
  def balance
  end

  def new_balance_nodes(nodes, newroot = @root)
  end

  # Return true if tree is balanced, in other word,
  # if the number of branchs is smaller than 2 raised
  # to the tree's depth
  def is_balanced?
  end

  # Return the max depth of the tree
  def get_depth_horiz(node = @root, depth = 1, maxdepth = 0)
    unless node.west.nil?
      maxdepth = get_depth(node.west, depth + 1, maxdepth)
    end

    unless node.east.nil?
      maxdepth = get_depth(node.east, depth + 1, maxdepth)
    end

    if node.west.nil? and node.east.nil? and
                           depth > maxdepth
      maxdepth = depth
    end
  end

  def get_depth_vert(node = @root, depth = 1, maxdepth = 0)
    unless node.south.nil?
      maxdepth = get_depth(node.south, depth + 1, maxdepth)
    end

    unless node.north.nil?
      maxdepth = get_depth(node.north, depth + 1, maxdepth)
    end

    if node.south.nil? and node.north.nil? and
                           depth > maxdepth
      maxdepth = depth
    end
  end

  # Return the number of branchs
  def number_nodes_horiz(node = @root)
    if node.nil?
      return 0
    else
      return 1 + number_nodes(node.west) +
                 number_nodes(node.east)
    end
  end

  def number_nodes_vert(node = @root)
    if node.nil?
      return 0
    else
      return 1 + number_nodes(node.south) +
                 number_nodes(node.north)
    end
  end

  def number_nodes_total(node = @root)
    if node.nil?
      return 0
    else
      return 1 + number_nodes(node.west)  +
                 number_nodes(node.east)  +
                 number_nodes(node.south) +
                 number_nodes(node.north)
  end
end