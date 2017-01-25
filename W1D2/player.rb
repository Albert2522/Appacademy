class Player
  attr_accessor :name

  def initialize(name = "Jim")
    @name = name
  end

  def get_guess
    puts "Enter guess"
    gets.strip.split(" ").map(&:to_i)
  end


end
