class Player

  def get_pos
    print "Please input your coordinates '3,4': "
    gets.chomp.split(",").map(&:to_i)
  end

  def get_move
    print "Please input 'r' to reveal or 'f' to flag: "
    gets.chomp
  end

end
