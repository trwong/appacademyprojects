class PolyTreeNode
  attr_accessor :value, :children, :parent
  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(object)
    if @parent && @parent != object
      @parent.children.delete(self)
    end
    if object && !object.children.include?(self)
      object.children << self
    end
    @parent = object
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    if !@children.include?(child_node)
      raise
    else
      @children.delete(child_node)
      child_node.parent = nil
    end
  end

  def dfs(target_value)
    stack = [self]
    return self if self.value == target_value
    stack.shift
    stack = self.children + stack
    stack.each do |node|
      result = node.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    que = [self]
    until que.empty?
      check_shift = que.shift
      return check_shift if check_shift.value == target_value
      que.concat(check_shift.children)
    end
    nil
  end
end
