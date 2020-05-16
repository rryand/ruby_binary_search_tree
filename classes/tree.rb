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
    return if node == value
    add_node(node, value)
  end

  def delete(value)
    parent_node = traverse(value)
    node = [parent_node.left, parent_node.right].find { |i| i == value }
    return puts "Did not find node." if node.nil?
    if node.left || node.right
      print "Node has children. Continue deletion? (y/n) "
      return if gets.chomp.downcase != 'y'
    end
    parent_node.left == value ? parent_node.left = nil : parent_node.right = nil
  end

  def balanced?(root = @root)
    p levels_count(root.left), levels_count(root.right)
    diff = levels_count(root.left) - levels_count(root.right)
    diff.abs <= 1
  end

  private

  def build_tree(array)
    p array
    return nil if array.empty?
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

  def levels_count(node)
    return -1 if node.nil?
    left = levels_count(node.left)
    right = levels_count(node.right)
    left > right ? left + 1 : right + 1
  end

  def traverse(value, root = @root)
    node = root > value ? root.left : root.right
    return root if node.nil? || node == value
    traverse(value, node)
  end
end