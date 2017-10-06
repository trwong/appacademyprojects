class Card
  attr_accessor :letter
  attr_reader :visible

  def initialize(letter)
    @letter = letter
    @visible = false
  end

  def hide
    @visible = false
  end

  def reveal
    @visible = true
  end

  def to_s
    @visible ? @letter : "#"
  end

  def ==(other_card)
    @letter == other_card.letter
  end
end
