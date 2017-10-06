require_relative 'player.rb'

class Game
  attr_accessor :player1, :player2, :fragment, :dictionary, :current_player, :previous_player, :losses

  def initialize(player1, player2, fragment = "")
    @player1 = player1
    @player2 = player2
    @fragment = fragment
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @current_player = player1
    @previous_player = player2
    @losses = {
      @player1.name => 0,
      @player2.name => 0
    }
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn(player)
    letter = player.guess
    if valid_play?(letter)
      fragment << letter
    else
      puts "--- Invalid letter! ---"
      take_turn(player)
    end
  end

  def valid_play?(letter)
    frag = @fragment + letter
    @dictionary.any? { |el| el.include?(frag) && el[0] == frag[0] } && letter.length == 1
  end

  def play_round
    until lost?
      puts "#{@current_player.name}'s Turn!"
      take_turn(@current_player)
      next_player!
    end
    puts "--- Round Over ---"
    puts "#{@current_player.name} won the round!"
    @losses[@previous_player.name] += 1
    @fragment = ""
  end

  def lost?
    dictionary.any? { |el| el == @fragment }
  end

  def run
    until @losses.any? { |k, v| v >= 5 }
      play_round
      puts "Current Score:"
      puts "#{@player1.name}: #{GHOST[@losses[@player1.name]]}"
      puts "#{@player2.name}: #{GHOST[@losses[@player2.name]]}"
    end
    puts "==== Game Over ===="
    puts "#{@current_player.name} Won the Game!"
  end

  GHOST = {
    0 => "",
    1 => "G",
    2 => "G H",
    3 => "G H O",
    4 => "G H O S",
    5 => "G H O S T",
  }
end

if $PROGRAM_NAME == __FILE__
  ghost = Game.new(Player.new("Tom"), Player.new("Jerry"))
  ghost.run
end
