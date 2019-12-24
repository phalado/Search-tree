class Node
  attr_accessor :left, :right, :x, :args

  # Create the tree's root with the base value x
  # and an unkown number of arguments.
  def initialize(x, *args)
    @x = x
    @args = args
    left = nil;
    right = nil;
  end
end