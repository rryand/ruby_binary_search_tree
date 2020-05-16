require_relative "node"

class Tree
  attr_reader :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  public

  def insert(value)
    node = traverse(value)
    add_node(node, value)
  end

  def balanced?(root = @root)
    diff = level(root.left) - level(root.right)
    diff.abs <= 1
  end

  private

  def build_tree(array)
    p array
    return Node.new(array[0]) if array.length < 2
    index = array.length / 2
    root = Node.new(array[index])
    root.left = build_tree(array[0...index])
    root.right = build_tree(array[index + 1..-1])
    root
  end

  def add_node(parent_node, value)
    node = Node.new(value)
    parent_node > value ? parent_node.left = node : parent_node.right = node
  end

  def level(node)
    return 1 if node.nil?
    left = level(node.left)
    right = level(node.right)
    left > right ? left + 1 : right + 1
  end

  def traverse(value, root = @root)
    node = root > value ? root.left : root.right
    return root if node.nil?
    traverse(value, node)
  end
end