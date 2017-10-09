require "colorize"
require_relative "cursor"

class Display
  def initialize()
    @cursor = Cursor.new([0,0], board = Board.new)
  end

  CHESS = {
    w_king: "\u2654",
    w_queen: "\u2655",
    w_rook: "\u2656",
    w_bishop: "\u2657",
    w_knight: "\u2658",
    w_pawn: "\u2659",
    b_king: "\u265A",
    b_queen: "\u265B",
    b_rook: "\u265C",
    b_bishop: "\u265D",
    b_knight: "\u265E",
    b_pawn: "\u265F",
    null: " "
  }


  def render
    @cursor.board.grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        pos = [x,y]
        item = CHESS[tile.symbol].encode('utf-8')
        if self[pos] == @cursor.cursor_pos && @cursor.selected
          item.blue.on_red.blink#.colorize(:background => :light_black)
        elsif self[pos] == @cursor.cursor_pos
          item.blue.on_red#.colorize(:background => :red)
        else
          item.blue.on_red#.colorize(:background => :light_yellow)
        end
        print "#{item} "
      end
      puts
    end
  end
  #     if pos == @cursor.cursor_pos && @cursor.selected
  #       if self[pos].null
  #         print "|   |".colorize(:green)
  #       else
  #         print "| X |".colorize(:green)
  #       end
  #     elsif pos == @cursor.cursor_pos
  #       if self[pos].null
  #         print "|   |".colorize(:red)
  #       else
  #         print "| X |".colorize(:red)
  #       end
  #     elsif self[pos].null
  #       print "|   |"
  #     else
  #       print "| X |"
  #     end
  #   end
  #   puts
  # end
  # puts "========================================"

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

Display.new.move_cursor
