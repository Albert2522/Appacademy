
require_relative  'NullPiece'
require_relative  'cursor'
require_relative  'Display'

class Board
  attr_accessor :size, :grid, :cursor_pos

  def initialize
    @size = 8
    self.make_starting_grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    self[pos] = piece
  end

  def dup

  end

  def move_piece(from_pos, to_pos)
    raise StandardError.new "No piece at start pos!" if self[from_pos].nil?
    piece = self[from_pos]
    unless piece.valid_moves.include?(to_pos)
      raise StandardError.new "Move is not valid"
    end
    self[from_pos], self[to_pos] = self[to_pos], self[from_pos]
    piece.location = to_pos
  end

  def move_piece!(color, from_pos, to_pos)

  end

  def checkmate?

  end

  def in_bounds?(pos)
    pos.all? { |i| i.between?(0,@size-1) }
  end

  protected
  def make_starting_grid
    @grid = Array.new(@size) { Array.new(@size) { NullPiece.new } }
    [0, 1 , 6 , 7].each do |row_num|
      @grid[row_num].map! { Piece.new }
    end
  end

  def find_king(color)

  end
end

b = Board.new
d = Display.new(b)
d.fake
