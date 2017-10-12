require_relative "deck"
require_relative "card"

class Hand
  attr_accessor :hand


  def initialize
    @hand = []
  end

  def receive_card(card)
    if @hand.length >= 5
      raise "Hand is full"
    else
      @hand << card
    end
  end

  def drop_card(card)
    if @hand.empty?
      raise "Hand is empty"
    elsif !@hand.include?(card)
      raise "Card is not in hand"
    else
      @hand.delete(card)
    end
  end

  def compare_hands(other_hand)
    self_hand_rank = self.hand_rank
    other_hand_rank = other_hand.hand_rank
    case self_hand_rank[0] <=> other_hand_rank[0]
    when -1
      other_hand
    when 1
      self
    when 0
      case self_hand_rank[1] <=> other_hand_rank[1]
      when -1
        other_hand
      when 1
        self
      when 0
        :split
      end
    end
  end

  def hand_rank
    if straight_flush
      [1, highest_value]
    elsif four_of_a_kind
      four_of_a_kind
    elsif full_house
      full_house
    elsif flush
      [4, highest_value]
    elsif straight
      [5, highest_value]
    elsif three_of_a_kind
      three_of_a_kind
    elsif two_pair
      two_pair
    elsif one_pair
      one_pair
    else
      [9, highest_value]
    end
  end

  private

  def flush
    hand.all? {|card| card.suit == hand[0].suit}
  end

  def straight
    values = []
    hand.each {|card| values << card.value}
    values.sort!
    values.each_cons(2).all? {|a,b| b == a + 1}
  end

  def straight_flush
    straight && flush
  end

  def highest_value
    values = []
    hand.each {|card| values << card.value}
    values.max
  end

  def card_value_count
    count = Hash.new(0)
    hand.each {|card| count[card.value] += 1}
    count
  end

  def four_of_a_kind
    count = card_value_count
    if count.values.include?(4)
      card_value = count.select {|k,v| v == 4}.keys
      [2, card_value].flatten
    end
  end

  def full_house
    count = card_value_count
    if count.values.include?(3) && count.values.include?(2)
      card_value = count.select {|k,v| v == 3}.keys
      [3, card_value].flatten
    end
  end

  def three_of_a_kind
    count = card_value_count
    if count.values.include?(3)
      card_value = count.select {|k,v| v == 3}.keys
      [6, card_value].flatten
    end
  end

  def two_pair
    count = card_value_count
    if count.values.count(2) == 2
      card_value = count.select {|k,v| v == 2}.keys.max
      [7, card_value].flatten
    end
  end

  def one_pair
    count = card_value_count
    if count.values.include?(2)
      card_value = count.select {|k,v| v == 2}.keys
      [8, card_value].flatten
    end
  end

end
