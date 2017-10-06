class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess
    print "Please input a letter: "
    gets.chomp
  end
end
