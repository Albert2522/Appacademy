require 'set'

class Game
attr_accessor :fragment, :current_player, :previous_player,
              :scores

def initialize(player1, player2, fragment, dictionary)
  @scores = { }
  scores[player1.name] = ""
  scores[player2.name] = ""
  @current_player = player1
  @previous_player = player2
  @fragment = fragment
  @dictionary = file_to_set(dictionary)
end

def file_to_set(path)
  set = Set.new
  file = File.open(path)
  file.each_line do |line|
    set.add(line)
  end
  set
end

def next_player!
  @current_player,@previous_player = @previous_player,@current_player
end

def renew(string)
  @fragment << string
end

def take_turn
  string = @current_player.get_letter(@fragment)
  while !valid_play?(string)
    puts "Wrong Input"
    string = @current_player.get_letter
  end
  self.renew(string)
end

def valid_play?(string)
  return false if string.length != 1
  arr1 = ('a'..'z').to_a
  arr1.include?(string)
end

def lose_session
  str = self.fragment
  @dictionary.include?(str)
end

def game_over?
  scores.each_key do |key|
    return true if scores[key] == "GHOST"
  end
  false
end

def add_score(player)
  string = @scores[player.name]
  result = "GHOST" - string
  @scores[player.name] << result[0]
end

def play
  while !self.game_over?
    while !self.lose_session
      self.take_turn
      self.next_player!
    end
    self.add_score(@previous_player)
  end
  lose = hash.key(value)
  if lose.size > 1
    puts "all lose"
    return
  end
  puts "#{lose[0]} lose this time"
end

end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_letter(fragment)
    puts "Currently the word is #{fragment}"
    puts "#{name} your turn"
    puts "Type any alphabetical lowcase character"
    letter = gets.chomp
    letter
  end

end

class Computer
  attr_accessor :name

  def initialize
    @name = "Computer"
  end

  def get_letter(fragment)
    alphabet = ('a'..'z').to_a
    letter = Random.new
    letter.rand('a'.ord..'z'.ord).chr
  end

end

if __FILE__ == $PROGRAM_NAME
  comp = Computer.new
  puts "Write your name please"
  name = gets.chomp
  player = Player.new(name)
  game = Game.new(player, comp, "", "/Users/appacademy/Desktop/W1D1/dictionary.txt")
  game.play
end
