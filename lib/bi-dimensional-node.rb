class Node
  attr_reader :x, :y
  attr_accessor :east, :west, :north, :south, :args

  # Create the tree's root with the base values x
  # and y and an unkown number of arguments.
  def initialize(x, y, *args)
    @x    = x
    @y    = y
    @args = args
  end
end
