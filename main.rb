
class Node
    attr_accessor :data, :right, :left

    def initialize(data)
        @data = data
        @right = nil
        @left = nil
    end

end

class Tree
    attr_accessor :node, :left, :right, :start, :finish, :mid, :root, :data

    def initialize(arr)
        @data = arr.sort!.uniq
        @root = build_tree(@data)
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

    def insert(num, node = @root)
        if num == node.data
            return node.data
        else
            if num < node.data
                node.left.nil? ? node.left = Node.new(num) : insert(num, node.left)
            else
                node.right.nil? ? node.right = Node.new(num) : insert(num, node.right)
            end
        end
    end

    def delete(num, node = @root)
        if node == nil
            return node
        end
        if num > node.data
            node.right = delete(num, node.right)
        elsif num < node.data
            node.left = delete(num, node.left)
        else
            if node.right.nil? && node.left.nil?
                node = nil
                return node
            elsif node.right.nil?
                temp = node.left
                node = temp
                node.left = nil
                return temp
            elsif node.left.nil?
                temp = node.right
                node = temp
                node.right = nil
                return temp
            else
                current_node = node.right
                while current_node.left != nil do
                    current_node = current_node.left
                end
                node.data = current_node.data
                node.right = delete(current_node.data, node.right)
            end
        end
        node
    end

    def find(num, node = @root)
        return node if node == nil
        if num < node.data
            node.left = find(num, node.left)
        elsif num > node.data
            node.right = find(num, node.right)
        else
            puts node
        end  
    end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(arr)
bst.pretty_print
bst.find(67)



