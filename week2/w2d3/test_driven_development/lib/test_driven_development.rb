class Array

  def my_uniq
    self.uniq
  end

  def two_sum
    result = []
    for i in 0...self.length + 1
      for j in i + 1...self.length
        result << [i, j] if (self[i] + self[j]).zero?
      end
    end
  result
  end

  def my_transpose
    self.transpose
  end

  def stock_picker
    answer = [0,0]
    for i in 0...self.length - 1
      for j in i+1...self.length
        answer = [i, j] if (self[j] - self[i]) > (self[answer[1]] - self[answer[0]])
      end
    end
    answer
  end

end

class Tower
  attr_accessor :grid

  def initialize
    @grid = [[3,2,1],[],[]]
  end

  def move(from, to)
    valid_move(from, to)
    @grid[to].push(@grid[from].pop)
  end

  def valid_move(from, to)
    if @grid[to].empty?
      # do nothing
    elsif @grid[from].empty? || @grid[from].last > @grid[to].last
      raise "Invalid move"
    end
  end

  def won
    @grid[1] == [3,2,1] || @grid[2] == [3,2,1]
  end

end
