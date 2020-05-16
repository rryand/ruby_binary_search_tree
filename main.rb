require_relative "classes/tree"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#tree = Tree.new([1, 7, 4, 23, 8])

#pp tree.root
p tree.balanced?
p tree.insert(10)
pp tree.root