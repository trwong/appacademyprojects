require 'singleton'

class Piece
  attr_reader :pos, :symbol, :board, :color

  def initialize(pos, color, symbol = :null, board)
    @pos = pos
    @color = color
    @symbol = symbol
    @board = board
  end

  def empty?
    @symbol == :null
  end

  def valid_moves(poss_moves)
    poss_moves = poss_moves.select do |move|
      move.all? { |el| el.between?(0,7) }
    end
    poss_moves = poss_moves.select do |move|
      @board[move].symbol == :null || @board[move].color != self.color
    end
  end

  def to_s
  end

  def empty?
  end

  # def symbol()
  # end
end

module SteppingPiece
  def moves(pos)
    # returns array of possible pos (not necessarily valid)
    diffs = move_diffs
    arr = []
    diffs.each do |el|
      arr << [el[0] + pos[0], el[1] + pos[1]]
    end
    arr
  end

  private
  def move_diffs
    move_diffs
  end
end

class King < Piece
  include SteppingPiece

  def initialize(pos, color, board)
    super
  end

  def valid_moves
    poss_moves = moves(@pos)
    super(poss_moves)
  end

  def move_diffs
    [[-1, -1], [-1, 0], [-1, -1], [0, 1], [1, 1], [1, 0],
    [1, -1], [0, -1]]
  end

  def symbol
    :king
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(pos, color, board)
    super
  end

  def valid_moves
    poss_moves = moves(@pos)
    super(poss_moves)
  end

  def symbol
    :knight
  end

  def move_diffs()
    return [[2, 1], [-2, -1], [2, -1], [-2, 1], [1, 2], [-1, -2],
    [-1, 2], [1, -2]]
  end
end

module SlidingPiece
  def moves
    poss_moves = []
    move_dirs.each do |dir|
      poss_moves += grow_unblocked_moves_in_dir(dir[0], dir[1])
    end
    poss_moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    avail_moves = []
    pos = @pos
    within_grid = pos.all? { |dir| dir.between?(0, 7) }

    while within_grid
      pos = [pos[0]+dx, pos[1]+dy]
      within_grid = pos.all? { |dir| dir.between?(0, 7) }
      break unless within_grid
      if @board[pos].color == :null
        avail_moves << pos
      elsif @board[pos].color != self.color
        avail_moves << pos
        break
      elsif @board[pos].color == self.color
        break
      end
    end

    avail_moves
  end

  private
  def move_dirs
    move_dirs
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
  end

  def valid_moves
    moves
  end

  def symbol
    :bishop
  end

  protected
  def move_dirs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
  end

  def valid_moves
    moves
  end

  def symbol
    :rook
  end

  protected
  def move_dirs()
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
  end

  def valid_moves
    moves
  end

  def symbol
    :queen
  end

  protected
  def move_dirs()
    [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end

class Pawn < Piece
  def initialize(pos, color, board)
    super
  end

  def symbol
    :pawn
  end

  def valid_moves
    forward_steps + side_attacks
  end

  protected
  def at_start_row?
    (self.color == :black && @pos[0] == 1) ||
    (self.color == :white && @pos[0] == 6)
  end

  def forward_dir
    if self.color == :black
      [1,0]
    elsif self.color == :white
      [-1,0]
    end
  end

  def forward_steps
    moves = []
    pos = [@pos[0] + forward_dir[0], @pos[1] + forward_dir[1]]
    pos2 = [@pos[0] + (forward_dir[0] * 2), @pos[1] + (forward_dir[1] * 2)]
    if at_start_row? && @board[pos2].symbol == :null
      moves << pos2
    end

    if @board[pos].symbol == :null
      moves << pos
    end
    moves
  end

  def side_attacks
    moves = []
    if self.color == :black
      attack = [[1, -1], [1, 1]]
    elsif self.color == :white
      attack = [[-1, -1], [-1, 1]]
    end
    attack.select do |coord|
      pos = [@pos[0] + coord[0], @pos[1] + coord[1]]
      if @board[pos].color != self.color && @board[pos].color != :null
        moves << pos
      end
    end
    moves
  end
end
#
class NullPiece < Piece
  # include Singleton

  def initalize
  end

  def symbol
    :null
  end

  def color
    :null
  end
end
