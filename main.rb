
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
            node
        end  
    end

    def level_order(node = @root, queue = [], output = [])
        return node if node == nil
        queue.push(node)
        while queue.empty? == false do
            current_node = queue[0]
            output.push(current_node.data)
            queue.push(current_node.left) if current_node.left != nil
            queue.push(current_node.right) if current_node.right != nil
            queue.shift
        end
        output
    end

    def preorder(node = @root, output = [])
        return if node.nil?
        output.push(node.data) unless node.data.nil?
        preorder(node.left, output)
        preorder(node.right, output)
        output
    end

    def inorder(node = @root, output = [])
        return if node.nil?
        preorder(node.left, output)
        output.push(node.data)
        preorder(node.right, output)
        output
    end

    def postorder(node = @root, output = [])
        return if node.nil?
        preorder(node.left, output)
        preorder(node.right, output)
        output.push(node.data)
    end

    def height(node)
        return -1 if node.nil?
        left_height = height(node.left)
        right_height = height(node.right)
        [left_height, right_height].max + 1
    end

    #auxiliary function to use a value instead of the node
    def height_by_node_value(value)
        node = find(value)
        height(node)
    end

    def depth(node)
        height(@root) - height_by_node_value(node)
    end

    def balanced?(node = @root, height = 0)
        return true if node.nil?
        left = balanced?(node.left, height(node.left))
        right = balanced?(node.right, height(node.right))
        if (height(node.left) - height(node.right)).abs <= 1
            true
        else
            return false
        end
    end

    def rebalance(node = @root)
        Tree.new(level_order)
    end

end

arr = (Array.new(15) { rand(1..100) })
bst = Tree.new(arr)
p bst.postorder





