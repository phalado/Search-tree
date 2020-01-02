class Node
  attr_reader :x
  attr_accessor :east, :west, :args

  # Create the tree's root with the base value x
  # and an unkown number of arguments.
  def initialize(x, *args)
    @x    = x
    @args = args
    east  = nil;
    west  = nil;
  end
end