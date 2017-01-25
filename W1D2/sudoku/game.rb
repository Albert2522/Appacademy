require_relative  'board'
require_relative  'tile'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    @board.solve_grid
    @board.display_solution
  #   while !@board.won?
  #     @board.display
  #     s1 = "Please enter the coordinates of the"
  #     s2 = " tile you would like to change"
  #     puts s1 + s2
  #     coords = gets.strip.split(" ").map(&:to_i)
  #     puts "What number would like to place there?"
  #     num = gets.strip
  #     bool = @board.checker(coords, num)
  #     if !bool
  #       puts "Incorrect value"
  #     else
  #       puts "Correct!"
  #       @board.get_answer(coords, num)
  #     end
  #     puts
  #     sleep(1)
  #     system('clear')
  #   end
  #   puts "WIN"
  end
end


if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
