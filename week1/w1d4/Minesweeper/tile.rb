class Tile
  attr_accessor :bomb, :revealed
  attr_reader :bomb_neighbors, :neighbors_hash

  def initialize(reveal = false, bomb = false)
    @revealed = reveal
    @bomb = bomb
    @bomb_neighbors = 0

  end

  def reveal
    @revealed = true
  end

  def neighbors(pos, board)
    @neighbors_hash = {}
    adjacent = [[-1,-1], [-1,0], [-1, 1], [0,1], [1,1], [1,0], [1,-1], [0,-1]]
    adjacent.each do |relative_pos|
      if relative_pos[0] + pos[0] < board.grid.length && relative_pos[1] + pos[1] < board.grid.length
        if relative_pos[0] + pos[0] >= 0 && relative_pos[1] + pos[1] >= 0
          x = pos[0] + relative_pos[0]
          y = pos[1] + relative_pos[1]
          @neighbors_hash[relative_pos] = board[[x,y]].bomb
        end
      end
    end
    @neighbors_hash
  end

  def neighbors_bombs
    @bomb_neighbors = @neighbors_hash.count { |_k,v| v }
  end

  # def recursive_reveal(pos, board)
  #   self.revealed = true
  #   return false if @neighbors_hash.values.include?(true)
  #   @neighbors_hash.keys.each do |key|
  #     next if board[key].revealed
  #     board[key].neighbors(key, board)
  #     board[key].neighbors_bombs
  #     recursive_reveal(key, board)
  #   end
  # end

  # def recursive_reveal(pos, board)
  #   self.revealed = true
  #   return false if !@bomb_neighbors.zero? && !board[pos].revealed
  #   neighbors(pos,board).keys.each do |pos1|
  #     if board[pos1].bomb_neighbors.zero? && !board[pos1].revealed
  #       recursive_reveal(pos1,board)
  #     end
  #   end
  # end

  def recursive_reveal(pos, board)
    board.grid.each_with_index do |row, x|
      row.each_with_index do |el, y|
        posi = [x,y]
        if board[posi].bomb_neighbors.zero?
          board[posi].revealed = true
          p " -----"
          p neighbors(posi, board).keys
          neighbors(posi, board).keys.each do |position|
            board[position].revealed = true
          end
        end
      end
    end
  end
end
