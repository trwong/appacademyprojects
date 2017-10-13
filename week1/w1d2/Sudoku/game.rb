require_relative  'board.rb'
require_relative  'tile.rb'


class Game
  def initialize(file = "sudoku1.txt")
    @board = Board.from_file(file)
  end

  def play
    until @board.solved?
      @board.render
      move = get_move
      @board.place_move(move)
    end
    puts "Congrats!"
  end

  def get_move
    print "Please input move: "
    gets.chomp.split.map(&:to_i)
  end
end

if __FILE__ == $0
  game = Game.new("sudoku1.txt")
  game.play
end
