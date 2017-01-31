require 'colorize'

class Display
  attr_accessor :cursor_pos, :board, :cursor

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @cursor = Cursor.new(@cursor_pos, @board)
  end

  def fake
    while true
      self.render
      @cursor.get_input
    end
  end

  def hanlde_key(key)

  end

  def render
    system("clear")
    @board.grid.each_with_index do |row, i|
      row_str = "______________________\n"
      row.each_with_index do |el, j|
        s = "|" +  el.to_s + "|"
        if [i, j] != @cursor.cursor_pos
          row_str << s
        elsif @cursor.selected
          row_str << s.colorize(:green)
        else
          row_str << s.colorize(:red)
        end
      end
      row_str << "\n"
      print row_str
    end
  end
end
