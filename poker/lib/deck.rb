require_relative 'card'
require_relative 'hand'

class Deck
  attr_reader :grid

  CARD_TYPES = %w(hearts spades diamonds clubs)
  CARD_NUMBERS = [1, 2, 3, 4 ,5 ,6 ,7 ,8, 9, 10, 11, 12 ,13, 14]
  def initialize
    @grid = Array.new
    build_deck
  end

  def build_deck
    52.times do |idx|
      idx2 = idx / 14
      @grid << Card.new(CARD_TYPES[idx2], CARD_NUMBERS[idx % 14])
    end
    shuffle_deck
  end

  def shuffle_deck
    @grid.shuffle!
  end

  def create_hand
    hand = [ ]
    shuffle_deck
    5.times do
      hand << @grid.pop
    end
    hand
  end

  def draw_cards(number_of_cards, cards_to_take)
    ans = [ ]
    shuffle_deck
    number_of_cards.times do
      ans << @grid.pop
    end
    @grid.concat(cards_to_take)
    shuffle_deck
    ans
  end

end
