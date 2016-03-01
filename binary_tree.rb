class Queue

  def initialize
    @store = []
  end

  def enqueue(x)
    @store << x
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def length
    @store.length
  end

  def empty?
    @store.empty?
  end

end

class Node
  attr_accessor :parent, :right, :left, :value, :visited
  def initialize(val)
    @parent = nil
    @right = nil
    @left = nil
    @visited = nil
    @value = val
  end
end

  def set_node(root,val)
    pointer = root
    if (val < pointer.value)
      if pointer.left == nil
        pointer.left = Node.new(val)
        pointer.left.parent = pointer
      else
        set_node(pointer.left,val)
      end
    else
      if val > pointer.value
        if pointer.right == nil
          pointer.right = Node.new(val)
          pointer.right.parent = pointer
        else
          set_node(pointer.right,val)
        end
      end
    end

  end

  def build_tree(values)
    values = values.shuffle
    root = nil
    values.each_with_index do |value,index|
      if index == 0
          root = Node.new(value)
      else
       set_node(root,value)
      end
    end
    return root
  end

  def print_tree(root)
    pointer = root
    node_queue = Queue.new
    print "#{pointer.value}   "
    #pointer.left != nil ? print pointer.left.value : print pointer.left
    if pointer.left != nil
      print pointer.left.value
    else
      #print pointer.left
      print "nil "
    end
    print " "
    if pointer.right != nil
      print pointer.right.value
    else
      #print pointer.right
      print "nil "
    end
    print "\n"
    node_queue.enqueue(pointer.left) if pointer.left != nil
    node_queue.enqueue(pointer.right) if pointer.right != nil
    while !node_queue.empty?
      pointer = node_queue.dequeue
      next if pointer.left == nil && pointer.right == nil
      print "#{pointer.value}   "
      #pointer.left != nil ? print pointer.left.value : print pointer.left
      if pointer.left != nil
        print pointer.left.value
      else
        #print pointer.left
        print "nil "
      end
      print " "
      if pointer.right != nil
        print pointer.right.value
      else
        #print pointer.right
        print "nil "
      end
      print "\n"
      node_queue.enqueue(pointer.left) if pointer.left != nil
      node_queue.enqueue(pointer.right) if pointer.right != nil
    end
  end

  def breadth_first_search(root, val)
    node_queue = Queue.new
    return root if val == root.value
    pointer = root
    node_queue.enqueue(pointer.left) if pointer.left != nil
    node_queue.enqueue(pointer.right) if pointer.right != nil

    while !node_queue.empty?
      pointer = node_queue.dequeue
      return pointer if pointer.value == val
      node_queue.enqueue(pointer.left) if pointer.left != nil
      node_queue.enqueue(pointer.right) if pointer.right != nil
    end
    return nil
  end

  def depth_first_search(root, val)
    node_stack = []
    return root if root.value == val
    if (root.left != nil && val < root.value)
      node_stack.push (root.left)
    elsif (root.right != nil && val > root.value)
      node_stack.push (root.right)
    end
    while !node_stack.empty?
      pointer = node_stack.pop()
      return pointer if pointer.value == val
      if (pointer.left != nil && val < pointer.value)
        node_stack.push (pointer.left)
      elsif (pointer.right != nil && val > pointer.value)
        node_stack.push (pointer.right)
      end
    end
    return nil
  end

  def dfs_rec(root,val)
    return root if root.value == val
    return nil if (root.left == nil && root.right == nil)
    dfs_rec(root.left,val) if (root.left != nil && val < root.value)
    dfs_rec(root.right,val) if (root.right != nil && val > root.value)
  end

values = [1,2,3,4,5,6,7,8,9,10]
tree = build_tree(values)
print_tree(tree)

node = breadth_first_search(tree,15)
#puts "search result = #{node.value}" if node != nil else print nil

node != nil ? (puts "search value: #{node.value}") : (puts "search value: nil")

node2 = depth_first_search(tree,6)
node2 != nil ? (puts "search value: #{node2.value}") : (puts "search value: nil")

node3 = dfs_rec(tree,8)
node3 != nil ? (puts "recursive search value: #{node3.value}") : (puts "recursive search value: nil")