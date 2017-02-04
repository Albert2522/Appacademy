require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' unless num.between?(0, @max - 1)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return if self.include?(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @num_buckets]
  end
end

class ResizingIntSet
  attr_accessor :count, :num_buckets, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    return if include?(num)
    resize! if @count == @num_buckets
    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  def [](num)
    @store[num % @num_buckets]
  end

  def resize!
    a = ResizingIntSet.new(@num_buckets * 2)
    @store.each do |arr|
      a.insert(arr.pop) until arr.empty?
    end
    @store = a.store
    @num_buckets *= 2
  end

  def help_count(num)
    num % @num_buckets
  end
end
