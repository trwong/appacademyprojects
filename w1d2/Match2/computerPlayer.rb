require "byebug"
class ComputerPlayer

  def initialize(size)
    @size = size
    @past_moves = {}
    @last_move = nil
    @first_turn = true
  end


  def random_move
    (0...@size).each do |row|
      (0...@size).each do |col|
        return [row, col] unless @past_moves.include?([row, col])
      end
    end
    (0...@size).each do |row|
      (0...@size).each do |col|
        return [row, col] unless @past_moves[[row, col]].visible
      end
    end
  end

  def get_move()
    if @first_turn
      @last_move = random_move
    else
      @last_move = guess_pair || random_move
    end
    next_turn!
    @last_move
  end

  def guess_pair
    last_letter = @past_moves[@last_move].letter
    pair = @past_moves.select do |k, v|
      last_letter == v.letter && k != @last_move
    end
    return nil if pair.empty?
     pair.keys[0]
  end

  def show_card(card)
    @past_moves[@last_move] = card
  end

  def next_turn!
    @first_turn = !@first_turn
  end

  def check_pairs
    pairs = @past_moves.select do |k, v|
      @past_moves.count[v] >= 2 && !v.visible
    end
    return nil if pairs.empty?

    pairs.sort! {|val1, val2| val1[1] <=> val2[1] }
    pairs.take(2).map {|val| val[0]}
  end

end
