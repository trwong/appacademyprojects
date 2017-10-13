require 'byebug'

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end


class MyStack
  attr_reader :store

  def initialize
    @store = [] #[{value: 0, min: 0, max: 0},
    #{value: 1, min: 0, max: 1}, {value: -1, min: -1, max: 1}]
  end

  def push(el)
    # debugger
    unless @store.empty? #issue with accessing end of array?
      new_max = (el > max ? el : max)
      new_min = (el < min ? el : min)
      el_history = {min: new_min, max: new_max, value: el}
    else
      el_history = {min: el, max: el, value: el}
    end
    @store << el_history
  end

  def pop
    el = @store.pop
  end

  def max
    # debugger
    # unless @store.empty?
    peek[:max]
    # else
    #   nil
    # end
  end

  def min
    # unless @store.empty?
    peek[:min]
    # else
    #   nil
    # end
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end


class StackQueue < MyStack
  def initialize
    @stack = MyStack.new
    @temp_stack = MyStack.new
  end

  def enqueue(el)
    @stack.push(el)
  end

  def dequeue
    @temp_stack.push(@stack.pop) until @stack.empty?
    @temp_stack.pop
    @stack.push(@temp_stack.pop) until @temp_stack.empty?
  end

  def size
    @stack.size
  end

  def empty?
    @stack.empty?
  end
end

class MinMaxStackQueue
  def initialize
    @stack = MyStack.new
  end

  def enqueue(el)
    @stack.push(el)
  end

  def dequeue
    @stack.store.delete_at(0)
  end

  def max
    @stack.max
  end

  def min
    @stack.min
  end
end
