class Piece
  attr_accessor :location

  def initialize(location = nil)
    @color = nil
    @location = location
  end

  def to_s
    self.class.to_s[0]
  end

  def empty?
  end

  def symbol
  end

  def valid_moves
  end

  def move_into_check(to_pos)
  end
end

module SlidingPiece

  def moves
    res = []
    vectors = moves_dirs
    vectors.each do |direction|
      res.concat(grow_unblocked_moves_in_dir(direction))
    end
    res
  end

  private
  def moves_dirs
    res = [ ]
    res.concat(horizontal_dirs) if @horizontal
    res.concat(diagonal_dirs) if @diagonal
    res
  end

  def vadd(pos, offset)
    [pos[0] + offset[0], pos[1] + offset[1]]
  end


  def valid?(loc)
    loc.all? { |n| n.between?(0,7) }
  end

  def horizontal_dirs
    [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def diagonal_dirs
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  def grow_unblocked_moves_in_dir(dir)
    res = []
    pos = @location
    while valid?(vadd(pos, dir))
      res << vadd(pos, dir)
      pos = res.last
    end
    res
  end

end

class Bishop < Piece
include SlidingPiece
# attr_accessor :diagonal, :horizontal

  def initialize(location)
    @diagonal = true
    @horizontal = false
    super
  end
end

module  SteppingPiece
end

b = Bishop.new([4, 4])
p b.moves
