require_relative "classes/tree"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#tree = Tree.new([1, 7, 4, 23, 8])

#pp tree.root
p tree.balanced?
p tree.insert(10)
p tree.insert(10)
#tree.delete(23)
#p tree.find(3)
#pp tree.root

#tree.level_order { |node| puts node.data }
#p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder