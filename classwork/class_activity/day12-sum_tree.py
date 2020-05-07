
#sum each values of a tree
def get_sum_tree(node):
    if node == None:
        return 0
    return node.data + get_sum_tree(node.left) + get_sum_tree(node.right)