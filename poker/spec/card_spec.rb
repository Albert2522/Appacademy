require 'rspec'
require 'card'
describe Card do

  subject(:card) {Card.new("hearts", 2)}

  describe "#initialize" do
    it "assigns a type to a card" do
      expect(card.type).to eq("hearts")
    end

    it "assigns a number value of card" do
      expect(card.number).to eq(2)
    end
  end
end
