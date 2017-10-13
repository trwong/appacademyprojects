require "colorize"

class Tile
  attr_reader :value

  def initialize(value)
    @value = value
    @given = value != 0
  end

  def set_value(value)
    @value = value if !@given
  end

  def to_s
    val = @value.zero? ? " " : @value.to_s
    color = @given ? :light_blue : :magenta
    val = val.colorize(color)
  end

  def ==(int)
    @value == int
  end

  def equal(int)
    self.==(int)
  end
end
