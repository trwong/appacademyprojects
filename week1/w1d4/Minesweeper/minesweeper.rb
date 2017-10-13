# TODO:
# player move validation
# player input reveal or flag
# tile attribute for flag
# recursive_reveal

# win condition
# lose condition in run if picked tile is bomb


require_relative 'Board'
require_relative 'Tile'
require_relative 'Player'


class Minesweeper
  attr_accessor :board

  def initialize(board_size)
    @board = Board.new(board_size)
    @player = Player.new
  end

  def play_turn
    @board.render
    pos = @player.get_pos
    move = @player.get_move
    if lost?(pos, move)
      puts "Tough luck!"
      reveal(pos)
      @board.render
      exit
    end
    # reveal(pos) if move == 'r'
    recursive_reveal(pos) if move == 'r'
  end

  def reveal(pos)
    @board[pos].revealed = true
  end

  def recursive_reveal(pos)
    @board[pos].recursive_reveal(pos, @board)
  end

  def run
    @board.populate
    play_turn until won?
  end

  def lost?(pos, move)
    p pos
    move == 'r' && @board[pos].bomb
  end

  def won?
    @board.grid.all? do |row|
      row.all? do |tile|
        tile.bomb || tile.revealed
      end
    end
  end

  def get_input
    @player.get_input
  end

  def valid_move?(pos)
    @board.valid_move?(pos)
  end

end

m = Minesweeper.new(9)
m.run
m.board[[0,0]].revealed = true
m.board.render
