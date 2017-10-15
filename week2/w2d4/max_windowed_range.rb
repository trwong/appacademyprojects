require_relative 'stacks_and_queues'
require'byebug'

def naive_windowed_max_range(array, window_size)
  current_max_range = nil
  (0..array.length - window_size).each do |i|
    arr = array[i...i + window_size]
    diff = arr.max - arr.min
    if current_max_range.nil? || diff > current_max_range
      current_max_range = diff
    end
  end
  current_max_range
end


def windowed_max_range(array, window_size)
  current_max_range = nil
  sq = MinMaxStackQueue.new
  window_size.times { |i| sq.enqueue(array[i]) }
  (0..array.length + 1 - window_size).each do |i|
    range = sq.max - sq.min
    current_max_range = range if current_max_range.nil? || range > current_max_range
    current_max_range
    # debugger
    sq.enqueue(array[window_size + i])
    sq.dequeue
  end
  current_max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
