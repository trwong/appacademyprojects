require "byebug"
require_relative "card"

class Board
  attr_accessor :board

  def initialize(size)
    @board = Array.new(size) { Array.new(size) }
    @size = size
    self.populate
  end

  def populate
    alphabet = ("a".."z").to_a
    alphabet += ("A".."Z").to_a
    alphabet += ("0".."9").to_a
    deck = []
    alphabet[0...(@size * @size) / 2].each do |letter|
      2.times { deck << letter }
    end
    deck.shuffle!
    @board.each_with_index do |row, i|
      row.each_with_index do |_el, j|
        @board[i][j] = Card.new(deck.pop)
      end
    end
  end

  def render
    # system("clear")
    @board.each do |row|
      row.each do |el|
        print "#{el} "
      end
      puts ""
    end
    puts "====="
  end

  def won?
    @board.all? do |row|
      row.all?(&:visible)
    end
  end

  def reveal(row, col)
    card = @board[row][col]
    card.reveal
    card
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, card)
    row, col = pos
    @board[row][col] = card
  end
end
