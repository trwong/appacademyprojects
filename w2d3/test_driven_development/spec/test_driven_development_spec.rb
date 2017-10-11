require 'rspec'
require 'test_driven_development'


describe '#my_uniq' do
  subject(:array) { [1, 2, 1, 3, 3] }

  it "should not modify the original array" do
    new_arr = array
    array.my_uniq
    expect(array).to be(new_arr)
  end

  it "should remove duplicates from array" do
    expect(array.my_uniq).to eq(array.uniq)
  end
end

describe "#two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }
  let(:array2) { [-2, -1, 0, 3, 4] }

  it "should sort pairs from smallest to largest" do
    expect(array.two_sum).to eq([[0,4],[2,3]])
  end

  it "should return empty array if there are no sums" do
    expect(array2.two_sum).to eq([])
  end

  it "should not double count" do
    expect(array.two_sum).to_not include([0,0])
  end
end

describe '#my_transpose' do
  subject(:matrix) {[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]
    }
    let (:result_matrix) {[
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]
      }

  it "should transpose the matrix" do
    expect(matrix.my_transpose).to eq(result_matrix)
  end

  it "should not modify original matrix" do
    temp = matrix
    matrix.my_transpose
    expect(matrix).to eq(temp)
  end
end

describe "#stock_picker" do
  subject(:stocks) { [9, 0, 5, 4, 8, 6] }

  it "should return an array of indices" do
    expect(stocks.stock_picker).to eq([1, 4])
  end

  it "should not sell before you buy" do
    expect(stocks.stock_picker[0]).to be <(stocks.stock_picker[1])
  end
end

describe Tower do
  subject(:towers) {Tower.new}

  describe '#initialize' do
    it "should initialize a nested array" do
      expect(towers.grid).to eq([[3,2,1],[],[]])
    end
  end

  describe '#move' do

    it "should move a piece from one pile to another" do
      towers.move(0,1)
      expect(towers.grid).to eq([[3,2],[1],[]])
    end

    it "should raise an error if invalid move" do
      towers.move(0,1)
      expect { towers.move(0,1) }.to raise_error("Invalid move")
    end
  end

  describe '#won' do

    it "should recognize when the game is won on peg 2" do
      towers.grid = [[],[3,2,1],[]]
      expect(towers.won).to be true
    end

    it "should recognize when the game is won on peg 3" do
      towers.grid = [[],[], [3,2,1]]
      expect(towers.won).to be true
    end

    it "should recognize when the game is not won" do
      expect(towers.won).to be false
    end
  end

end
