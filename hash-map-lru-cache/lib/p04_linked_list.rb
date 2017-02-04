class Link
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
  end
end

class LinkedList
  include Enumerable

  attr_accessor :curr_link
  def initialize
    @tail = Link.new
    @head = @tail
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.key.nil?
  end

  def get(key)
    return @curr_link.val if include?(key)
  end

  def include?(key)
    tmp = @head
    while tmp
      if tmp.key == key
        @curr_link = tmp
        return true
      end
      tmp = tmp.next
    end
    false
  end

  def append(key, val)
    if empty?
      @tail.key = key
      @tail.val = val
    else
      new_item = Link.new(key, val)
      @tail.next = new_item
      new_item.prev = @tail
      @tail = new_item
    end

  end

  def update(key, val)
    @curr_link.val = val if include?(key)
  end

  def remove(key)
    return unless include?(key)
    tmp = @curr_link

    if @head != @tail
      @head = tmp.next if tmp == @head
      @tail = tmp.prev if tmp == @tail
    else
      @head = Link.new
    end

    tmp.prev.next = tmp.next if tmp.prev
    tmp.next.prev = tmp.prev if tmp.next

  end

  def each
    tmp = @head
    while tmp
      yield(tmp)
      tmp = tmp.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
