require_relative "classes/tree"

def print_balanced(tree)
  puts "Tree is balanced? #{tree.balanced?}"
end

def print_tree_traversal_types(tree)
  [:level_order, :preorder, :inorder, :postorder].each do |method|
    puts method.to_s + ": "
    p tree.send(method)
  end
end

puts "=" * 80
puts "Binary Search Tree".center(80)
puts "=" * 80

tree = Tree.new(Array.new(15) { rand(1..100) })

print_balanced(tree)

print_tree_traversal_types(tree)

puts
(1..10).each do |number|
  tree.insert(number)
end
puts "1..10 inserted."
print_balanced(tree)

puts "rebalancing..."
tree.rebalance!
print_balanced(tree)
puts

print_tree_traversal_types(tree)