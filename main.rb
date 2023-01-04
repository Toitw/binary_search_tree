class Node
    attr_accessor :data, :right, :left

    def initialize(data)
        @data = data
        @right = nil
        @left = nil
    end

end

class Tree

    def initialize(arr)
        @arr = arr
        @root = nil
    end

    def build_tree
        @arr = @arr.sort!.uniq
        puts @arr
    end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(arr)
bst.build_tree