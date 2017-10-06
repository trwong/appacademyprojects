require_relative "board"
require_relative "humanPlayer"
require_relative "computerPlayer"
class Game

  def initialize(size, player)
    @board = Board.new(size)
    @previously_guessed_pos = nil
    @player = player
  end

  def make_guess(move)
    card = @board.reveal(move[0], move[1])
    if @previously_guessed_pos.nil?
      @previously_guessed_pos = card
    else
      if card.letter == @previously_guessed_pos.letter
        puts "You Got A Match!!!"
      else
        @board.render
        sleep(0)
        @previously_guessed_pos.hide
        card.hide
      end
      @previously_guessed_pos = nil
    end
    card
  end

  def play
    until @board.won?
      @board.render
      move = @player.get_move
      card = make_guess(move)
      @player.show_card(card)
    end
    @board.render
    puts "Congratulations you WON!!!!!"
  end

end

if __FILE__ == $0
  size = 10
  player = ComputerPlayer.new(size)
  game = Game.new(size, player)
  game.play
end
