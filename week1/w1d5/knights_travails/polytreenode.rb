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
<<<<<<< HEAD
    p "target #{target_value}"
    p "self.value #{self.value}"
=======
>>>>>>> refs/remotes/origin/master
    return self if self.value == target_value
    stack.shift
    stack = self.children + stack
    stack.each do |node|
      result = node.dfs(target_value)
      return result if result
    end
    nil
  end

<<<<<<< HEAD
 #  def dfs(target = nil, &prc)
 #   raise "Need a proc or target" if [target, prc].none?
 #   prc ||= Proc.new { |node| node.value == target }
 #   p "target #{target}"
 #   p "self.value #{self.value}"
 #   return self if prc.call(self)
 #
 #   children.each do |child|
 #     result = child.dfs(&prc)
 #     return result unless result.nil?
 #   end
 #
 #   nil
 # end

=======
>>>>>>> refs/remotes/origin/master
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
