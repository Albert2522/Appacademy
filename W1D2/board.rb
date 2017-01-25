require_relative "card"

class Board
  attr_accessor :grid

  def initialize(size)
    init(size)
  end

  def init(size)
    @grid = []
    samples_array = []
    all_values = [ ]

    (size[0] / 2).times do
      temp_array = []

      sample = ("a".."z").to_a.shuffle[0..size[1]]
      while !not_include(all_values, sample)
        sample = ("a".."z").to_a.shuffle[0..size[1]]
      end
      samples_array.push(sample.dup)

      size[1].times do
        el = sample.pop
        all_values.push(el)
        card = Card.new(el)
        temp_array << card
      end

      @grid << temp_array
    end
    (size[0] / 2).times do
      sample = samples_array.pop
      temp_array = []
      size[1].times do
        card = Card.new(sample.pop)
        temp_array << card
      end
      @grid << temp_array
    end
    self.shuffle_board!
  end

  def not_include(all_values, sample)
    sample.each do |char|
      return false if all_values.include?(char)
    end
    true
  end

  def shuffle_board!
    @grid.map(&:shuffle!)
    @grid.shuffle!
  end

  def show(pos)
    i, j = pos
    @grid[i][j].face_status = "opened"
    self.display
    @grid[i][j].face_status = "closed"
  end

  def display
    @grid.each do |row|
      row.each do |elem|
        print elem.face_val if elem.face_status == "opened"
        print "X" if elem.face_status == "closed"
        print " "
      end
      puts
    end
  end

  def answer(previous_guess, guess)
    row1, col1 = previous_guess
    row2, col2 = guess
    if @grid[row1][col1].face_val == @grid[row2][col2].face_val
      @grid[row1][col1].face_status = "opened"
      @grid[row2][col2].face_status = "opened"
      puts "Nice job!"
    else
      puts "Try again"
      @grid[row1][col1].face_status = "opened"
      @grid[row2][col2].face_status = "opened"
      self.display
      @grid[row1][col1].face_status = "closed"
      @grid[row2][col2].face_status = "closed"
    end
  end

  def won?
    @grid.each do |row|
      row.each do |card|
        return false if card.face_status == "closed"
      end
    end
    true
  end
end
