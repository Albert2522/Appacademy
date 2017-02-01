require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'cursor'

class Game
  attr_accessor :player1, :player2, :board, :current_player, :display,
                :cursor

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @cursor = Cursor.new([0, 0], @board)
    @display = Display.new(@cursor, @board)
    player1.color_play == "white" ? @current_player = @player1 : @player2
  end

  def play
    until @board.checkmate?(@current_player.color_play)
      begin
        pos = @current_player.play_turn(cursor, display)
        notify_players
        @board.move_piece(@current_player.color_play, pos[0], pos[1])
        swap_turn!
      rescue StandardError => e
        puts e.message
        retry
      end
    end
    swap_turn!
    @display.render
    puts "#{@current_player.name} WON!"
  end

  private

  def notify_players
    puts "Player #{@current_player.name} - now is your turn"
  end

  def swap_turn!
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end
end

a = HumanPlayer.new("White", "white")
b = HumanPlayer.new("Black", "black")
game = Game.new(a, b)
game.play
