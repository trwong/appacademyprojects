require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    eject! until @map.count <= @max
    if @map.include?(key)
      update_node!(@map[key])
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    node = @store.append(key, val)
    @map.set(key, node)
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.append(node.key, node.val)
    @map[node.key] = node
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
  end
end
