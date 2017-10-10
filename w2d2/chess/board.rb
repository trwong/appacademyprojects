require_relative 'piece.rb'
# require_relative 'display.rb'
# require_relative 'cursor.rb'

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    @grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        pos = [x,y]
        if pos == [7,4]
          self[pos] = King.new(pos, :white, self)
        elsif pos == [0,3]
          self[pos] = King.new(pos, :black, self)
        elsif pos == [7, 1] || pos == [7, 6]
          self[pos] = Knight.new(pos, :white, self)
        elsif pos == [0, 1] || pos == [0, 6]
          self[pos] = Knight.new(pos, :black, self)
        elsif pos == [7, 2] || pos == [7, 5]
          self[pos] = Bishop.new(pos, :white, self)
        elsif pos == [0, 2] || pos == [0, 5]
          self[pos] = Bishop.new(pos, :black, self)
        elsif pos == [7, 0] || pos == [7, 7]
          self[pos] = Rook.new(pos, :white, self)
        elsif pos == [0, 0] || pos == [0, 7]
          self[pos] = Rook.new(pos, :black, self)
        elsif pos == [7, 3]
          self[pos] = Queen.new(pos, :white, self)
        elsif pos == [0, 4]
          self[pos] = Queen.new(pos, :black, self)
        elsif x == 6
          self[pos] = Pawn.new(pos, :white, self)
        elsif x == 1
          self[pos] = Pawn.new(pos, :black, self)
        else
          self[pos] = NullPiece.new(pos, :null, self)
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    raise StandardError if self[start_pos].null || !self[end_pos].null
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new(start_pos, :null, self)
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

board = Board.new()
pos = [1, 0]
p board[pos].valid_moves
# display = Display.new(Cursor.new([0,0], board))
# display.move_cursor
