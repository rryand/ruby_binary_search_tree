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
    return if node.left == value || node.right == value
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

  def find(value)
    parent_node = traverse(value)
    [parent_node.left, parent_node.right].find { |i| i == value }
  end

  def level_order(queue = [@root], arr = [], &block)
    return arr if queue.empty?
    node = queue.shift
    block_given? ? yield(node) : arr << node.data
    [node.left, node.right].each { |node| queue << node unless node.nil? }
    level_order(queue, arr, &block)
  end

  [:preorder, :inorder, :postorder].each do |method|
    define_method(method) do |node = @root, arr = [], &block|
      return if node.nil?
      block_given? ? yield(node) : arr << node.data if method == :preorder
      self.send(method, node.left, arr, &block)
      block_given? ? yield(node) : arr << node.data if method == :inorder
      self.send(method, node.right, arr, &block)
      block_given? ? yield(node) : arr << node.data if method == :postorder
      arr unless block_given?
    end
  end

  def depth(node = @root)
    return -1 if node.nil?
    left = depth(node.left)
    right = depth(node.right)
    left > right ? left + 1 : right + 1
  end

  def balanced?(root = @root)
    diff = depth(root.left) - depth(root.right)
    diff.abs <= 1
  end

  def rebalance!
    arr = level_order
    @root = build_tree(arr.sort.uniq)
  end

  private

  def build_tree(array)
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

  def traverse(value, root = @root)
    node = root > value ? root.left : root.right
    return root if node.nil? || node == value
    traverse(value, node)
  end
end