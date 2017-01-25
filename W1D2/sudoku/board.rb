require 'colorize'
require_relative 'tile'

class Board
  attr_accessor :grid, :grid_sol, :current_index

  def initialize
    tmp = self.read_sudoku_file
    populate_board(tmp)
    grid_for_sol
  end

  def grid_for_sol
    @grid_sol = [ ]
    @grid.each do |row|
      tmp = [ ]
      row.each do |elem|
        tmp.push(elem.value)
      end
      @grid_sol.push(tmp)
    end
  end

  def solve_grid
    bool = already_solved
    return true if bool
    i = 1
    while i <= 9
      if fit(i)
        row, col = @current_index
        @grid_sol[row][col] = i
        return true if solve_grid
        @grid_sol[row][col] = '-'
      end
      i += 1
    end
    false
  end

  def already_solved
    @grid_sol.each_with_index do |row, i|
      row.each_with_index do |elem, j|
        if elem == '-'
          @current_index = [i, j]
          return false
        end
      end
    end
    true
  end



  def fit(num)
    coords = @current_index
    #tile = @grid[i][j]
    return false if !row(coords, num)
    return false if !col(coords, num)
    return false if !sq(coords, num)
    true
  end

  def row(coords, num)
    row1, col1 = coords
    j = 0
    while j < 9
      v = @grid_sol[row1][j]
      if num == v && j != col1
        return false
      end
      j += 1
    end
    true
  end

  def col(coords, num)
    row1, col1 = coords
    j = 0
    while j < 9
      v = @grid_sol[j][col1]
      return false if num == v && j != row1
      j += 1
    end
    true
  end

  def sq(coords, num)
    row1, col1 = coords
    row = (row1 / 3) * 3
    col = (col1 / 3) * 3
    i = row
    while i < row + 3
      j = col
      while j < col + 3
        v = @grid_sol[i][j]
        if v == num && i != row1 && j != col1
          return false
        end
        j += 1
      end
      i += 1
    end
    true
  end




  def read_sudoku_file
    file = File.open("sudoku.txt")
    arr = file.readlines
    tmp = [ ]
    arr.each do |row|
      tmp.push(row.strip.split(""))
    end
    tmp
  end

  def populate_board(tmp)
    @grid = [ ]
    tmp.each do |row|
      tiles = [ ]
      row.each do |elem|
        tiles.push(Tile.new('-', false)) if elem == '0'
        tiles.push(Tile.new(elem, true)) if elem != '0'
      end
      @grid.push(tiles)
    end
  end

  def display
    i = 0
    puts
    print " "
    23.times { print "_".colorize(:yellow) }
    puts
    while i < 9
      j = 0
      print "| ".colorize(:yellow)
      while j < 9
        v = @grid[i][j].value
        print v.colorize(:red) if @grid[i][j].given
        print v.colorize(:blue) if !@grid[i][j].given
        print " "
        print "| ".colorize(:yellow) if j % 3 == 2
        j += 1
      end
      puts
      print " " if i % 3 == 2
      23.times { print "_".colorize(:yellow) if i % 3 == 2 }
      puts if i % 3 == 2
      i += 1
    end
    puts
  end

  def won?
    # @grid.each_with_index do |row, i|
    #   row.each_with_index do |elem, j|
    #     return false if !checker([i, j], elem.value)
    #   end
    # end

    i = 0
    while i < 9
      j = 0
      while j < 9
        v = @grid[i][j].value
        return false if !checker([i, j], v)
        j += 1
      end
      i += 1
    end
    true
  end

  def display_solution
    @grid_sol.each do |row|
      row.each do |elem|
        print elem
        print " "
      end
      puts
    end
  end

  def get_answer(coords, num)
    row, column = coords
    @grid[row][column].value = num
  end

  def checker(coords, num)
    i, j = coords
    tile = @grid[i][j]
    return false if !row_check(coords, num)
    return false if !col_check(coords, num)
    return false if !sq_check(coords, num)
    return false if tile.given
    true
  end

  def row_check(coords, num)
    row1, col1 = coords
    j = 0
    while j < 9
      v = @grid[row1][j].value
      if num == v && j != col1
        return false
      end
      j += 1
    end
    true
  end

  def col_check(coords, num)
    row1, col1 = coords
    j = 0
    while j < 9
      v = @grid[j][col1].value
      return false if num == v && j != row1
      j += 1
    end
    true
  end

  def sq_check(coords, num)
    row1, col1 = coords
    row = (row1 / 3) * 3
    col = (col1 / 3) * 3
    i = row
    while i < row + 3
      j = col
      while j < col + 3
        v = @grid[i][j].value
        if v == num && i != row1 && j != col1
          p v
          p [i, j]
          return false
        end
        j += 1
      end
      i += 1
    end
    true
  end
end
