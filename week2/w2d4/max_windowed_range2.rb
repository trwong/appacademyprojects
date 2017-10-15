require_relative 'stacks_and_queues2'
require 'byebug'

def windowed_max_range(arr, window)
  # debugger
  que = MinMaxStackQueue.new
  window.times { |i| que.enque(arr[i]) }
  range = que.max - que.min
  (window...arr.length).each do |i|
    que.deque
    que.enque(arr[i])
    new_range = que.max - que.min
    range = new_range if new_range > range
  end
  range
end




p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p "answer"
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p "answer"
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
