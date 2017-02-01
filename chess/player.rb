

class Player
  attr_accessor :name, :color_play
  def initialize(name, color_play)
    @name = name
    @color_play = color_play
  end
end


class HumanPlayer < Player
  def play_turn(cursor, display)
    start_pos = nil
    end_pos = nil
    while start_pos == nil || end_pos == nil
      system("clear")
      display.render
      puts "Player #{@name} - now is your turn"
      pos = cursor.get_input
      unless pos.nil?
        if start_pos == nil
          start_pos = pos
        else
          end_pos = pos
        end
      end
    end
    [start_pos, end_pos]
  end
end

class ComputerPlayer < Player

end
