require_relative "board"
require_relative "card"
require_relative "player"

class Game
  attr_accessor :board, :previous_guess, :player

  def initialize(board, player)
    @board = board
    @previous_guess = nil
    @player = player
  end

  def play
    while !@board.won?
      @board.display
      guess = @player.get_guess
      @board.show(guess)
      @previous_guess = guess
      guess = @player.get_guess
      @board.answer(@previous_guess, guess)
      sleep(1)
      system('clear')
    end
    @board.display
    puts "AWESOME!"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Board.new([4, 4]), Player.new)
  game.play
end
