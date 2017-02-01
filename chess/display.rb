require 'colorize'

class Display
  attr_accessor :cursor_pos, :board, :cursor

  def initialize(cursor, board)
    @board = board
    @cursor_pos = [0, 0]
    @cursor = cursor
  end

  def hanlde_key(key)

  end

  def render
    @board.grid.each_with_index do |row, i|
      row_str = "\u2500" * 16
      row_str += "\n"
      row.each_with_index do |el, j|
        pipe = "\u2502"
        s = el.to_s
        if [i, j] != @cursor.cursor_pos
          row_str << s + pipe
        elsif @cursor.selected
          row_str << s.colorize(:color => :green, :background => :light_yellow)+ pipe
        else
          row_str << s.colorize(:color => :red, :background => :light_yellow)+ pipe
        end
      end
      row_str << "\n"
      print row_str
    end
  end
end
