require 'rspec'
require 'tdd'

describe Array do
  subject(:array) {Array.new}
  describe "#my_uniq" do
    it "handles an empty array" do
      expect([].my_uniq).to eq([])
    end

    it "removes duplicate values" do
      expect([1,2,2].my_uniq).to eq([1,2]).or(eq([2,1]))
    end

    it "returns the my_uniq elements in the same order" do
      expect([1,2,2,2].my_uniq).to eq([1,2])
    end

    it "doesn't modify the array if no duplicates are found" do
      expect([1 ,2 ,3, 4].my_uniq).to eq([1, 2, 3 ,4])
    end

    it "doesn't modify the original array" do

      arr = [1, 2, 2, 1]
      arr.my_uniq
      expect(arr).to eq([1, 2, 2, 1])
    end
  end
  describe "#two_sum" do
    it "returns all pairs that add to zero" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]]).or(eq([[2, 3], [0, 4]]))
    end

    it "handles an empty array" do
      expect([].two_sum).to eq([])
    end

    it "returns an empty array if no two_sum pair was found" do
      expect([-1, 0, 2, -3, 5].two_sum).to eq([])
    end

    it "returns pairs in the right order" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
  end
  describe "#my_transpose" do
    it "turns every row into a column" do
        a = [[0, 1, 2],
             [3, 4, 5],
             [6, 7, 8]]
        b = a.transpose
        expect(a.my_transpose).to eq(b)
    end

    it "doesn't modify original array" do
      a = [[0, 1, 2],
           [3, 4, 5],
           [6, 7, 8]]
      c = a.dup
      a.my_transpose
      expect(a).to eq(c)
    end

    it "raise an error if rows size differs" do
      a = [[0, 1, 2],
           [3, 4],
           [6, 7, 8]]
      expect{a.my_transpose}.to raise_error("rows size differs")
    end



  end
  describe "#stock_picker" do
    it "buy day falls before sell day" do
      expect([1, 7, 6, 1].stock_picker).to eq([0, 1])
    end

    it "returns the highest profit pair" do
      expect([2, 1, 7, 3].stock_picker).to eq([1, 2])
    end

    it "returns an empty array if profit is impossible" do
      expect([6, 5, 4, 3].stock_picker).to eq([])
    end


  end
end

describe TowersofHanoi do
  subject(:game)  { TowersofHanoi.new }

  describe "#initialize" do
    it "creates a 2D array that contains 3 arrays" do
      expect(game.towers.size).to be(3)
      expect(game.towers[0].class).to be(Array)
    end

    it "the first tower contains all the 3 discs" do
      expect(game.towers[0].size).to be(3)
    end

    it "the discs are arranged in an descending order" do
      expect(game.towers[0]).to eq([3, 2, 1])
    end
  end

  describe "#valid_move?" do
    it "raise an error if player tries to move disc from empty tower" do
      expect{game.valid_move?(1, 2)}.to raise_error("tower is empty")
    end

    it "raise an error if player tries to move disc on top of smaller disc" do
      game.towers[0] = [3]
      game.towers[2] = [2, 1]
      expect{game.valid_move?(0, 2)}.to raise_error("can't place disc on smaller disc")
    end

    it "returns true if move is valid" do
      expect(game.valid_move?(0, 1)).to be true
    end

  end

  describe "#move" do

    it "makes the required move" do
      game.move(0, 1)
      expect(game.towers[1]).to eq([1])
    end

  end

  describe "#won?" do

    it "returns true if all discs are at target tower" do
      game.towers[0] = [ ]
      game.towers[2] = [3, 2, 1]
      expect(game.won?).to be true
    end

    it "returns false if not all the discs are at target tower" do
      game.towers[0] = [1]
      game.towers[2] = [3, 2]
      expect(game.won?).to be false
    end

  end

  # describe "#play" do
  #   it "in case of invalid move, the game doesn't crash" do
  #     expect{game.move(1, 2)}.not_to raise_error
  #   end
  # end
end
