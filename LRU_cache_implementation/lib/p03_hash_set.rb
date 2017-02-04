require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  private

  def [](num)
    @store[num.hash % @store.length]
  end
end
