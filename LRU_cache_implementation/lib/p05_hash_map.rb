require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :num_buckets, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def include?(key)
    hashed_key = key.hash
    @store[hashed_key % num_buckets].include?(key)
  end

  def set(key, val)
    hashed_key = key.hash
    if include?(key)
      @store[hashed_key % num_buckets].update(key, val)
    else
      resize! if @count == @num_buckets
      @store[hashed_key % num_buckets].append(key, val)
      @count += 1
    end
  end

  def get(key)
    hashed_key = key.hash
    @store[hashed_key % num_buckets].get(key)
  end

  def delete(key)
    hashed_key = key.hash
    @store[hashed_key % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |linked_list|
      next if linked_list.empty?
      linked_list.each do |link|
        yield(link.key, link.val)
      end
    end
    @store
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def resize!
    new_hash = HashMap.new(@num_buckets * 2)
    each do |k, v|
      new_hash[k] = v
    end
    @store = new_hash.store
  end

end
