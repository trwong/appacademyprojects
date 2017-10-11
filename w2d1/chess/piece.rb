class Piece
  attr_reader :null, :pos, :symbol, :board

  def initialize(pos, null = true, symbol = :null, board)
    @pos = pos
    @null = null
    @symbol = symbol
    @board = board
  end

  def empty?
    @symbol == :null
  end

  def valid_moves(possible_moves)
    possible_moves.select do |move|
      @board[move].empty?
    end
  end

  def to_s
  end

  def empty?
  end

  def symbol()
  end
end

module SlidingPiece

  private
  def move_diffs(symbol)
    if symbol == :bishop

    elsif symbol == :rook

    elsif symbol == :queen
    end
  end
end

module SteppingPiece
  def moves(symbol, pos)
    diffs = move_diffs(symbol)
    arr = []
    diffs.each do |el|
      arr << [el[0] + pos[0], el[1] + pos[1]]
    end
    arr
  end

  private
  def move_diffs(symbol)
    if symbol == :knight
      return [[2, 1], [-2, -1], [2, -1], [-2, 1], [1, 2], [-1, -2],
      [-1, 2], [1, -2]]
    elsif symbol == :king
      return [[-1, -1], [-1, 0], [-1, -1], [0, 1], [1, 1], [1, 0],
      [1, -1], [0, -1]]
    end
  end
end

class King < Piece
  include SteppingPiece

  def initialize(pos, null = false, symbol = :king, board)
    super
  end

  def valid_moves
    poss_moves = SteppingPiece.moves(@symbol, @pos)
    super(poss_moves)
  end
end

class Knight < Piece
  include SteppingPiece

  def symbol()
  end

  protected
  def move_diffs()
  end
end

class Bishop < Piece
  include SlidingPiece

  def symbol()
  end

  protected
  def move_dirs()
  end
end

class Rook < Piece
  include SlidingPiece

  def symbol()
  end

  protected
  def move_dirs()
  end
end

class Queen < Piece
  include SlidingPiece

  def symbol()
  end

  protected
  def move_dirs()
  end
end

class Pawn < Piece
  def symbol()
  end

  def moves()
  end

  protected
  def at_start_row?()
  end

  def forward_dir()
  end

  def forward_steps()
  end

  def side_attacks()
  end
end

class NullPiece < Piece
end
