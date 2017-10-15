require_relative 'card'

class Deck
  attr_reader :deck

  SUITS = [:spades, :diamonds, :clubs, :hearts].freeze
  VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].freeze

  def initialize
    @deck = []
    create_deck
  end

  def create_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        @deck << Card.new(value, suit)
      end
    end
  end

  def shuffle
    @deck.shuffle!
  end

  def deal_a_card
    if @deck.empty?
      raise "Deck is empty"
    else
      @deck.pop
    end
  end

end
