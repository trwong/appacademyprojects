require_relative "polytreenode.rb"

class KnightPathFinder
  MOVES = [[1,2], [2,1], [-1,2], [1, -2], [-2,1],
    [-2,-1], [2,-1], [-1, -2]]
  attr_accessor :visited_positions


  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @board = Array.new(8) { Array.new(8) }
  end

  def build_move_tree(start_pos)
    que = [start_pos]
    until que.empty?
      shift_pos = que.shift
      self[shift_pos] = PolyTreeNode.new(shift_pos)
      moves = new_move_positions(shift_pos)
      que += moves
      moves.each do |move|
        self[move] = PolyTreeNode.new(move)
        self[move].parent = self[shift_pos]
      end
    end
  end

  def bfs(target_value)
    que = [self]
    until que.empty?
      check_shift = que.shift
      return check_shift if check_shift.value == target_value
      que.concat(check_shift.children)
    end
    nil
  end

  def new_move_positions(pos)
    new_moves = valid_moves(pos).reject { |spot| @visited_positions.include?(spot) }
    @visited_positions += new_moves
    new_moves
  end

  def valid_moves(current_pos)
    pos_moves = []
    MOVES.each do |adj|
      x = current_pos[0] + adj[0]
      y = current_pos[1] + adj[1]
      pos = [x, y]
      pos_moves << pos if valid_move?(pos)
    end
    pos_moves
  end

  def valid_move?(pos)
    pos[0] >= @board.length || pos[1] >= @board.length || pos[0] < 0 || pos[1] < 0
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @board[x][y] = val
  end

end


p pos = [2,4]
p kpf = KnightPathFinder.new(pos)
p kpf.valid_moves(pos)
# p kpf.build_move_tree(pos)
# p kpf.visited_positions
