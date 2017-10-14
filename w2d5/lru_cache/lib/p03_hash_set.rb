require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
      @count += 1
      if @count > num_buckets
        resize!
      end
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def resize!
    new_num_buckets = 2 * num_buckets
    temp_store = @store
    @store = Array.new(new_num_buckets) { Array.new }
    temp_store.flatten.each do |el|
      self[el] << el
    end
  end

  def [](num)
    @store[ num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

end
