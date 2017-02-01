require 'byebug'
require_relative 'piece'
require_relative  '/Users/appacademy/Desktop/w2d1/chess/null_piece.rb'


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
    x, y = pos
    @grid[x][y] = piece
  end

  def dup

  end

  def move_piece(color_play, from_pos, to_pos)
    raise StandardError.new "No piece at start pos!" if self[from_pos].is_a? NullPiece
    piece = self[from_pos]
    raise StandardError.new "That's not your piece" if piece.color != color_play
    arr = piece.moves
    if !arr.include?(to_pos)
      puts "Select another position or figure"
      raise StandardError.new "Move is not valid"
    end
    move_unless_incheck(from_pos, to_pos, color_play, true)
  end

  def move_unless_incheck(from_pos, to_pos, color, show_error)
    # returns deleted piece
    piece = self[from_pos]
    self[from_pos] = NullPiece.new
    piece.location = to_pos
    deleted_piece = self[to_pos]
    self[to_pos] = piece
    # if in check undo it
    if check?(color)
      # fix it
      piece.location = from_pos
      self[from_pos] = piece
      self[to_pos] = deleted_piece
      raise StandardError.new "You can't put yourself in check!" if show_error
      return true
    end
    false
  end

  def check?(color_play)
    king = find_king(color_play)
    en_color = (color_play == "white" ? "black" : "white")
    loc = king.location
    arr = all.select { |el| el.color == en_color && el.moves.include?(loc)}
    !arr.empty?
  end

  def all
    @grid.flatten
  end

  def checkmate?(color)
    return false if !check?(color)
    # we are in check
    king = find_king(color)
    locs = king.moves
    locs.map! do |loc|
      move_unless_incheck(king.location, loc, color, false)
    end
    # check all locs the king can go, is he still in check in all of them
    locs.all? { |in_check| in_check == true }
    # check all other of my pieces, can I make the king not in check?
  end

  def in_bounds?(pos)
    pos.all? { |i| i.between?(0,@size-1) }
  end

  protected
  def make_starting_grid
    @grid = Array.new(@size) { Array.new(@size) { NullPiece.new(nil, nil, nil) } }
    j = 0
    while j < 8
      @grid[1][j] = Pawn.new('black', [1, j], self)
      @grid[6][j] = Pawn.new('white', [6, j], self)
      j += 1
    end
    #Rook
    @grid[0][0] = Rook.new('black', [0, 0], self)
    @grid[0][7] = Rook.new('black', [0, 7], self)
    @grid[7][0] = Rook.new('white', [7, 0], self)
    @grid[7][7] = Rook.new('white', [7, 7], self)
    #Knight
    @grid[0][1] = Knight.new('black', [0, 1], self)
    @grid[0][6] = Knight.new('black', [0, 6], self)
    @grid[7][1] = Knight.new('white', [7, 1], self)
    @grid[7][6] = Knight.new('white', [7, 6], self)
    #Bishop
    @grid[0][2] = Bishop.new('black', [0, 2], self)
    @grid[0][5] = Bishop.new('black', [0, 5], self)
    @grid[7][2] = Bishop.new('white', [7, 2], self)
    @grid[7][5] = Bishop.new('white', [7, 5], self)
    #King
    @grid[0][4] = King.new('black', [0, 4], self)
    @grid[7][4] = King.new('white', [7, 4], self)
    #Queen
    @grid[0][3] = Queen.new('black', [0, 3], self)
    @grid[7][3] = Queen.new('white', [7, 3], self)
    # [0, 1 , 6 , 7].each do |row_num|
    #   @grid[row_num].map! { Piece.new(nil, self) }
    # end
  end

  def find_king(color)
    @grid.each do |row|
      row.each do |el|
        return el if (el.is_a? King) && el.color == color
      end
    end
  end
end

# b = Board.new
# d = Display.new(b)
# d.fake
