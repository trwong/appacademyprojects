class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    recur_get(key, @head)
  end

  def include?(key)
    recur_include(key, @head)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    current_last = last
    current_last.next = new_node
    new_node.next = @tail
    new_node.prev = current_last
    @tail.prev = new_node
  end

  def update(key, val)
    recur_update(key, val, @head)
  end

  def remove(key)
    recur_remove(key, @head)
  end

  include Enumerable

  def each(&prc)
    target = first
    until target == @tail
      prc.call(target)
      target = target.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private
  def recur_update(key, val, node)
    return  if node == @tail
    if node.key == key
      node.val = val
    else
      recur_update(key, val, node.next)
    end
  end

  def recur_get(key, node)
    return nil if node == @tail
    if node.key == key
      return node.val
    else
      recur_get(key, node.next)
    end
  end

  def recur_remove(key, node)
    return nil if node == @tail
    if node.key == key
      node.remove
    else
      recur_remove(key, node.next)
    end
  end

  def recur_include(key, node)
    return false if node == @tail
    if node.key == key
      return true
    else
      recur_include(key, node.next)
    end
  end

end
