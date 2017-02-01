require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dess) { Dessert.new("type", 10, chef) }
  describe "#initialize" do
    it "sets a type" do
      expect(dess.type).to eq("type")
    end

    it "sets a quantity" do
      expect(dess.quantity).to be(10)
    end

    it "starts ingredients as an empty array" do
      expect(dess.ingredients).to be_empty
    end


    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new("type", "asda", chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    let(:chef) { double("chef") }
    subject(:dess) { Dessert.new("type", 10, chef)}
    before(:example) do
      dess.add_ingredient("Sugar")
    end
    it "adds an ingredient to the ingredients array" do
      expect(dess.ingredients).not_to be_empty
    end

  end

  describe "#mix!" do
    let(:chef) { double("chef") }
    subject(:dess) { Dessert.new("type", 10, chef)}

    before (:example) do
      dess.add_ingredient("1")
      dess.add_ingredient("2")
      dess.add_ingredient("3")
    end

    it "shuffles the ingredient array" do
      arr = dess.ingredients.dup
      expect(dess.mix!).not_to be(arr)
    end
  end

  describe "#eat" do
    let(:chef) { double("chef") }
    subject(:dess) { Dessert.new("type", 10, chef)}

    it "subtracts an amount from the quantity" do
      dess.eat(5)
      expect(dess.quantity).to be(5)
    end

    it "raises an error if the amount is greater than the quantity" do
        expect{dess.eat(100)}.to raise_error("not enough left!")
    end

  end

  describe "#serve" do
    let(:chef) { double("chef", :titleize => "Chef the Great Baker") }
    subject(:dess) { Dessert.new("type", 10, chef)}

    it "contains the titleized version of the chef's name" do
      expect(dess.serve).to include("Chef the Great Baker")
    end
  end

  describe "#make_more" do
    let(:chef) { double("chef") }
    subject(:dess) { Dessert.new("type", 10, chef)}

    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake) { :dess }
      expect(chef).to receive(:bake) { :dess}
      dess.make_more
    end
  end
end
