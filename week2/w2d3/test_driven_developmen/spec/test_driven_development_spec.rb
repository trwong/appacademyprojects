require 'rspec'
require 'test_driven_development'


describe '#my_uniq' do
  subject(:array) { [1, 2, 1, 3, 3] }

  it "should not modify the original array" do
    new_arr = array
    array.my_uniq
    expect (array).to be(new_arr)
  end

  it "should remove duplicates from array" do
    expect (array.my_uniq).to eq(array.uniq)
  end
end

describe "#two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }
  let(:array2) { [-2, -1, 0, 3, 4] }

  # it "should sort pairs from smallest to largest" do
  #   expect(array.two_sum).to eq([[0,4],[2,3]])
  # end

  # it "should return empty array if there are no sums" do
  #   expect(array2.two_sum).to eq([])
  # end

  it "should not double count" do
    expect(array.two_sum).to_not include([0,0])
  end
end
