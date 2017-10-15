require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  CHESS_WHITE = {
    king: "♔",
    queen: "♕",
    rook: "♖",
    bishop: "♗",
    knight: "♘",
    pawn: "♙",
    null: " "
  }

  CHESS_BLACK = {
    king: "♚",
    queen: "♛",
    rook: "♜",
    bishop: "♝",
    knight: "♞",
    pawn: "♟",
    null: " "
  }


  def render
    @board.grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        pos = [x,y]
        if tile.color == :black
          item = "#{CHESS_BLACK[tile.symbol]} "
        else
          item = "#{CHESS_WHITE[tile.symbol]} "
        end
        if pos == @cursor.cursor_pos && @cursor.selected
          print item.colorize(:background => :red).blink
        elsif pos == @cursor.cursor_pos
          print item.colorize(:background => :light_black)
        elsif (x.even? && y.even?) || (x.odd? && y.odd?)
          print item.colorize(:background => :white)
        else
          print item.colorize(:background => :light_white)
        end

      end
      puts
    end
  end

  def move_cursor
    while true
      system("clear")
      self.render
      @cursor.get_input
      # p @cursor.cursor_pos
    end
  end

  def [](pos)
    x, y = pos
    @cursor.board.grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    @cursor.board.grid[x][y] = mark
  end
end


board = Board.new()
d = Display.new(board)
d.move_cursor
