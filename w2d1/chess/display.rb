require "colorize"
require_relative "cursor"

class Display
  def initialize()
    @cursor = Cursor.new([0,0], board = Board.new)
  end

  CHESS = {
    w_king: "♔",
    w_queen: "♕",
    w_rook: "♖",
    w_bishop: "♗",
    w_knight: "♘",
    w_pawn: "♙",
    b_king: "♚",
    b_queen: "♛",
    b_rook: "♜",
    b_bishop: "♝",
    b_knight: "♞",
    b_pawn: "♟",
    null: " "
  }


  def render
    @cursor.board.grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        pos = [x,y]
        item = "#{CHESS[tile.symbol]} "
        if pos == @cursor.cursor_pos && @cursor.selected
          print item.colorize(:background => :red)
        elsif pos == @cursor.cursor_pos
          print item.colorize(:background => :light_black)
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

d = Display.new
d.move_cursor
