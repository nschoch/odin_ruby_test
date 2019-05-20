class Node
  attr_accessor :value, :parent_node, :left_child_node, :right_child_node

  def initialize(value=nil, parent_node=nil, left_child_node=nil, right_child_node=nil)
    @value = value
    @parent_node = parent_node
    @left_child_node = left_child_node
    @right_child_node = right_child_node
  end

end

class BinaryTree
  attr_reader :root

  def initialize(arr)
    @root = nil
    build_tree(arr)
  end

  def build_tree(arr)
    @root = Node.new(arr.shift)
    arr.each do |x|
      add_node(@root, x)
    end
  end

  def add_node(parent_node, value)
    if parent_node.nil?
      Node.new(value)
    else
      if value < parent_node.value
        if parent_node.left_child_node.nil?
          parent_node.left_child_node = Node.new(value, parent_node)
        else
          add_node(parent_node.left_child_node, value)
        end
      else
        if parent_node.right_child_node.nil?
          parent_node.right_child_node = Node.new(value, parent_node)
        else
          add_node(parent_node.right_child_node, value)
        end
      end
    end
    return nil
  end

  def breadth_first_search(value)
    return nil if @root.nil?
    queue = [@root]
    until queue.empty?
      current = queue.shift
      if current.value == value
        return current
      end
      current.left_child_node.nil? ? nil : queue.push(current.left_child_node)
      current.right_child_node.nil? ? nil : queue.push(current.right_child_node)
    end
  end

  def depth_first_search(value)
    return nil if @root.nil?
    queue = [@root]
    
    until queue.empty?
      current = queue.shift
      if current.value == value
        return current
      end
      current.right_child_node.nil? ? nil : queue.unshift(current.right_child_node)
      current.left_child_node.nil? ? nil : queue.unshift(current.left_child_node)
    end
  end

  def dfs_rec(value, node=@root)
    return nil if node.nil?
    return nil if value.nil?
    return node if value == node.value
    dfs_rec(value, node.right_child_node) or dfs_rec(value, node.left_child_node)
  end


end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
puts arr.to_s
tree = BinaryTree.new(arr)
# a = tree.breadth_first_search(1)
# a = tree.depth_first_search(324)
a = tree.dfs_rec(23)
puts a