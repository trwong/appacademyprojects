require_relative 'piece.rb'

class Board
  attr_reader :grid
  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    @grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        pos = [x,y]
        if x.between?(0,1)
          self[pos] = Piece.new(pos, false, :w_pawn)
        elsif x.between?(6,7)
          self[pos] = Piece.new(pos, false, :b_pawn)
        else
          self[pos] = Piece.new(pos, true)
        end
      end
    end
  end



  def move_piece(start_pos, end_pos)
    raise StandardError if self[start_pos].null || !self[end_pos].null
    self[end_pos] = self[start_pos]
    self[start_pos] = Piece.new(start_pos, true)
  end

  def in_bounds(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    @grid[x][y] = mark
  end
end
