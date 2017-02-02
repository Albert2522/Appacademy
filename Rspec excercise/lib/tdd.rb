class Array

  def my_uniq
    ans = [ ]
    i = 0
    while i < length
      ans << self[i] unless ans.include?(self[i])
      i += 1
    end
    ans
  end

  def two_sum
    pairs = []
    each_index do |idx|
      (idx + 1...length).each do |idx2|
        pairs << [idx, idx2] if self[idx] + self[idx2] == 0
      end
    end

    pairs
  end

  def my_transpose
    l = self[0].size
    raise "rows size differs" unless self.all? { |row| row.size == l }
    ans = [ ]
    i = 0
    while i < length
      j = 0
      tmp = [ ]
      while j < length
        tmp << self[j][i]
        j += 1
      end
      ans << tmp
      i += 1
    end
    ans
  end

  def stock_picker
    i = 0
    days = [0, 1]
    diff = self[1] - self[0]
    while i < length - 1
      j = i + 1
      while j < length
        if self[j] - self[i] > diff
          diff = self[j] - self[i]
          days = [i, j]
        end
        j += 1
      end
      i += 1
    end
    return [] if diff <= 0
    p days
  end

end

class TowersofHanoi
 attr_accessor :towers
  def initialize
    @towers = Array.new(3) {Array.new}
    @towers[0] = [3, 2, 1]
  end

  def play
    until won?
      begin
      pos = prompt_input
      from_pos, to_pos = pos
      valid_move?(from_pos, to_pos)
      rescue
        puts "invalid input"
      retry
      end
      move(from_pos, to_pos)
      won?
    end
  end

  def move(from_pos, to_pos)
    temp = towers[from_pos].pop
    towers[to_pos].push(temp)
  end

  def prompt_input
    puts "Please select a tower to pick a disk and a tower to drop it. (i.e. 1,2)"
    pos = gets.chomp.split(",").map(&:to_i)
    pos.map! { |x| x - 1}
  end

  def valid_move?(from_pos, to_pos)
    raise "tower is empty" if @towers[from_pos].empty?
    return true if towers[to_pos].empty?

    if towers[to_pos].first > towers[from_pos].first
      return true
    else
      raise "can't place disc on smaller disc"
    end
  end

  def won?
    towers[2].size == 3
  end


end
