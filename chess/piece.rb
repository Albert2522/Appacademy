require 'byebug'

class Piece
  attr_accessor :color, :location, :board

  def initialize(color=nil, location = nil, board=nil)
    @color = color
    @location = location
    @board = board
  end

  def to_s
    symbol
  end

  def symbol

  end

  def empty?
  end

  def valid_moves(board)
    @board = board
  end

  def valid?(loc)
    return true if loc.all? { |n| n.between?(0, @board.size-1) }
    false
  end

  def enemy?(other_piece)
    @color != other_piece.color
  end

  def friend?(other_piece)
    !enemy?(other_piece)
  end

  def move_into_check(to_pos)
  end
end

module  SteppingPiece
  def moves
    pos = @location
    move_diffs(pos)
  end

  private

  def move_diffs(pos)
    return king_moves(pos) if self.is_a? King
    knight_moves(pos)
  end

  def king_moves(pos)
    moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    moves.concat([[1, 1], [1, -1], [-1, -1], [-1, 1]])
    answer = [ ]
    x, y = pos
    moves.each do |arr|
      answer << [x + arr[0], y + arr[1]]
    end
    filter_moves(answer)
  end

  def knight_moves(pos)
    offsets1 = [[-2, -1], [-2, 1], [2, 1], [2, -1]]
    offsets2 = [[-1, -2], [-1, 2], [1, 2], [1, -2]]
    offsets = offsets1 + offsets2
    x, y = pos
    answer = [ ]
    offsets.each do |arr|
      answer << [x + arr[0], y + arr[1]]
    end
    filter_moves(answer)
  end

  def filter_moves(moves)
    # make sure move is not friend
    moves.select! { |move| valid?(move) }
    arr = moves.reject { |loc| friend?(@board[loc]) }
    arr
  end

end

module SlidingPiece

  def moves
    res = []
    vectors = moves_dirs
    vectors.each do |dir|
      res.concat(grow_unblocked_moves_in_dir(dir))
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

  def horizontal_dirs
    [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def diagonal_dirs
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  def grow_unblocked_moves_in_dir(dir)
    # run through all null pieces, stop at a piece that is not null
    # include that piece if color != self
    res = []
    #debugger
    pos = @location
    while valid?(vadd(pos, dir))
      res << vadd(pos, dir)
      pos = res.last
      real_piece = !(@board[pos].is_a? NullPiece)
      if real_piece && friend?(@board[pos])
        res.pop
        break
      end
      break if real_piece && self.enemy?(@board[pos])
    end
    res
  end

end


class King < Piece
include SteppingPiece

  def symbol
    return "\u265A" if @color == "black"
    "\u2654"
  end
end

class Knight < Piece
include SteppingPiece

  def symbol
    return "\u265E" if @color == "black"
    "\u2658"
  end

end

class Bishop < Piece
include SlidingPiece
# attr_accessor :diagonal, :horizontal

  def initialize(color, location, board)
    @diagonal = true
    @horizontal = false
    super
  end

  def symbol
    return "\u265D" if @color == "black"
    "\u2657"
  end
end

class Rook < Piece
include SlidingPiece
# attr_accessor :diagonal, :horizontal

  def initialize(color, location, board)
    @diagonal = false
    @horizontal = true
    super
  end

  def symbol
    return "\u265C" if @color == "black"
    "\u2656"
  end

end

class Queen < Piece
include SlidingPiece
# attr_accessor :diagonal, :horizontal

  def initialize(color, location, board)
    @diagonal = true
    @horizontal = true
    super
  end

  def symbol
    return "\u265B" if @color == "black"
    "\u2655"
  end

end

class Pawn < Piece


  def moves
    answer = [ ]
    answer << forward_dir(1)
    answer << forward_dir(2) if at_start_row?
    answer.concat(side_attacks)
    answer
  end

  def symbol
    return "\u265F" if @color == "black"
    "\u2659"
  end

  protected

  def at_start_row?
    x, y = @location
    return true if @color == 'white' && x == 6
    return true if @color == "black" && x == 1
    false
  end

  def forward_dir(step)
    x, y = @location
    loc =  [x - step, y] if @color == 'white'
    loc = [x + step, y] if @color == "black"
    return loc if @board[loc].is_a? NullPiece
    []
  end



  def side_attacks
    x, y = @location
    offset = (@color == "black" ? 1 : - 1)
    answer = [[x + offset, y + 1], [x + offset, y - 1]]
    return answer.select { |loc| !@board[loc].is_a? NullPiece }
  end

end
