require 'byebug'

class Board
  attr_reader :grid

  def initialize(board_size = 9, num_bombs = 5)
    @grid = Array.new(board_size) { Array.new(board_size) { Tile.new } }
    @num_bombs = num_bombs
  end

  def populate
    @num_bombs.times do
      x = rand(0...@grid.size)
      y = rand(0...@grid.size)
      pos = [x,y]
      self[pos].bomb == true ? redo : self[pos].bomb = true
    end
    find_bomb_neighbors
  end

  def find_bomb_neighbors
    @grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        pos = [x, y]
        tile.neighbors(pos, self)
        tile.neighbors_bombs
      end
    end
  end

  # def render_test
  #   @grid.each do |row|
  #     row.each do |tile|
  #       value = tile.bomb ? "B" : tile.bomb_neighbors
  #       print "#{value} "
  #     end
  #     puts
  #   end
  # end

  def render
    @grid.each do |row|
      row.each do |tile|
        if tile.revealed
          value = tile.bomb ? "X" : tile.bomb_neighbors
          print "#{value} "
        else
          print ". "
        end
      end
      puts
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end
end
