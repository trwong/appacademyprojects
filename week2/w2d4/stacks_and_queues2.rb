class MyQueue
  def initialize
    @store = []
  end

  def enque(el)
    @store << el
  end

  def deque
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  attr_reader :store

  def initialize
    @store = []
  end

  def push(el)
  if el.is_a?(Hash)
    @store.push(el)
  elsif el.is_a?(Fixnum)
      if @store.empty?
        @store.push({value: el, min: el, max: el})
      else
        min = self.peek[:min] < el ? self.peek[:min] : el
        max = self.peek[:max] > el ? self.peek[:max] : el
        @store.push({value: el, min: min, max: max})
      end
    end
  end

  def max
    peek[:max]
  end

  def min
    peek[:min]
  end

  def pop
    @store.pop
  end

  def peek
    @store.last
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end
end

# class StackQueue
#   def initialize
#     @in = MyStack.new
#     @out = MyStack.new
#   end
#
#   def enque(el)
#     @in.push(el)
#   end
#
#   def deque
#     if @out.empty?
#       until @in.empty?
#         @out.push(@in.pop)
#       end
#     end
#     @out.pop
#   end
#
#   def size
#     @in.count + @out.count
#   end
#
#   def empty?
#     @in.empty? && @out.empty?
#   end
# end

class MinMaxStackQueue
  attr_reader :in, :out

  def initialize
    @in = MyStack.new
    @out = MyStack.new
  end

  def enque(el)
    @in.push(el)
  end

  def deque
    if @out.empty?
      until @in.empty?
        @out.push(@in.pop)
      end
    end
    p @in.size
    p @out.size
    @out.pop
  end

  def max
    if @in.empty?
      @out.max
    elsif @out.empty?
      @in.max
    else
      @in.max > @out.max ? @in.max : @out.max
    end
  end

  def min
    if @in.empty?
      @out.min
    elsif @out.empty?
      @in.min
    else
      @in.min < @out.min ? @in.min : @out.min
    end
  end

end
