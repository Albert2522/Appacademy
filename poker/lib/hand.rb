require_relative 'card'

class Hand
  attr_reader :cards, :abs_value

  def initialize(cards)
    @cards = cards
    calc__current_value
  end

  def
end
