require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    linkedlist = @store[bucket(key)]
    if linkedlist.include?(key)
      linkedlist.update(key, val)
    else
      linkedlist.append(key, val)
      @count += 1
      if @count >= num_buckets
        resize!
      end
    end
  end

  def get(key)
    # result = nil
    @store.each do |bucket|
      result = bucket.get(key)
      # p result
      return result unless result.nil?
    end
    nil
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |el|
        prc.call(el.key, el.val)
      end
    end
    self
  end
  include Enumerable

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    temp.each do |bucket|
      bucket.each do |link|
        @store[bucket(link.key)].append(link.key, link.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
