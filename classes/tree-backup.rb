require_relative "node"

class Tree
  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(array.uniq)
  end

  private

  def build_tree(array)
    root = Node.new(array.shift)
    until array.empty?
      new_node = Node.new(array.shift)
      node = traverse(root, new_node)
      new_node > node ? node.right = new_node : node.left = new_node
    end
    pp root
    p balanced?(root)
    root
  end

  def traverse(root, data)
    node = root > data ? root.left : root.right
    return root if node.nil?
    traverse(node, data)
  end

  def balanced?(root = @root)
    diff = depth(root.left) - depth(root.right)
    diff.abs <= 1
  end

  def level(node)
    return 1 if node.nil?
    left = depth(node.left)
    right = depth(node.right)
    left > right ? left + 1 : right + 1
  end
end