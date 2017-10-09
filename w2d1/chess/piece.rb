class Piece
  attr_reader :null, :pos, :symbol

  def initialize(pos, null = true, symbol = :null)
    @pos = pos
    @null = null
    @symbol = symbol
  end
end
