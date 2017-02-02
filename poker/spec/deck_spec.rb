require 'rspec'
require 'deck'

describe Deck do

  subject (:deck) { Deck.new}
  describe "#initialize" do
    

    it "creates an Array instance to store the cards in" do
      expect(deck.grid.class).to be(Array)
    end
    it "the array instance's size is equal to 52" do
      expect(deck.grid.size).to be(52)
    end
    it "populates the array instance with Card objects" do
      expect(deck.grid.sample.class).to be(Card)
    end
  end

  describe "#create_hand" do

    it "returns five cards from the deck" do
      expect(deck.create_hand.size).to be(5)
      expect(deck.create_hand.first.class).to be(Card)
      expect(deck.create_hand.class).to be(Array)
    end
  end

  describe "#shuffle_deck" do

    it "shuffles the deck of cards" do
      expect(deck.grid.dup).not_to eq(deck.shuffle_deck)
    end

  end

  describe "#draw_cards" do
    let(:card1) { Card.new("hearts", 1) }
    it "pulls correct number of cards out of the deck" do
      ans = [card1]
      expect(deck.draw_cards(3, ans).size).to be(3)
    end

    it "puts the cards taken form the player back into the deck" do
      ans = [card1]
      deck.draw_cards(1, ans)
      expect(deck.grid).to include(card1)
    end
  end

end
