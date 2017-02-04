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
    if @map.include?(key)
      update_link!(@map[key])
    else
      calc!(key)
    end
    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    eject!
    val = @prc.call(key)
    @store.append(key, val)
    @map[key] = @store.last
  end

  def update_link!(link)
    @store.put_in_tail(link)
  end

  def eject!
    if @map.count >= @max
      @map.delete(@store.first.key)
      @store.remove(@store.first.key)
    end

  end
end
