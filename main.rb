
class Node
    attr_accessor :data, :right, :left

    def initialize(data)
        @data = data
        @right = nil
        @left = nil
    end

end

class Tree
    attr_accessor :node, :left, :right, :start, :finish, :mid

    def initialize(arr)
        @arr = arr.sort!.uniq
        @root = build_tree(@arr)
    end

    def build_tree(arr)
        if arr.empty?
            return
        else
            mid = arr.length/2
            node = Node.new(arr[mid])
            node.left = build_tree(arr.slice(0, mid))
            node.right = build_tree(arr.slice(mid + 1, arr.length - 1))
        end
        node
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(arr)
bst.pretty_print