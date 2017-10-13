require "byebug"
require_relative 'tile'

class Board
  attr_accessor :grid

  NUMS = (1..9).to_a

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    grid = Array.new (9)
    grid = File.readlines(file)
    grid.map! do |line|
      vals = line.chomp.chars
      vals.map{|val| Tile.new(val.to_i)}
    end
    Board.new(grid)
  end

  def render
    @grid.each do |line|
      line.each do |tile|
        print "#{tile}|"
      end
      puts ''
    end
    return true
  end

  def solved?
    row_solved(@grid) && col_solved && squares_solved
  end

  def row_solved(grid)
    grid.all? do |row|
      NUMS.all? { |num| row.include?(num) }
    end
  end

  def col_solved
    row_solved(@grid.transpose)
  end

  def sq_solved(square)
    NUMS.all? { |num| square.include?(num) }
  end

  def squares_solved
    (0...9).all? do |square|
      square_vals = []
      top = (square / 3) * 3
      left = (square % 3) * 3
      (top...top + 3).each do |row|
        (left...left + 3).each do |el|
          tile = @grid[row][el]
          square_vals << tile
        end
      end
      sq_solved(square_vals)
    end
  end

  def place_move(arr)
    row, col, num = arr
    @grid[row][col].set_value(num)
  end
end
