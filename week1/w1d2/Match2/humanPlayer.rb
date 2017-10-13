class HumanPlayer

  def initialize(_size)
  end
  
  def get_move()
    puts "Enter a move? (0 0)"
    input = gets.chomp
    input.split(' ')
         .map(&:to_i)
  end

  def show_card(letter)
    # Do nothing
  end
end
