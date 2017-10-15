require 'byebug'

def my_min(arr)
  arr.each do |el|
    min = true
    arr.each do |compare|
      min = false if compare < el
    end
    return el if min
  end
  nil
end

def my_min(arr)
  min = arr[0]
  arr.each do |el|
    min = el if el < min
  end
  min
end

def slow_largest_contiguous_subsum(list)
  largest = []
  (0...list.length).each do |i|
    (i...list.length).each do |j|
      sum = list[i..j].inject(:+)
      largest = list[i..j] if sum > largest.inject(:+)
    end
  end
  largest.inject(:+)
end

# def largest_contiguous_subsum(list)
#   highest_sum = 0
#   list.each_index do |idx|
#     list[idx..-1].inject do |acc, el|
#       highest_sum = acc if acc > highest_sum
#       acc = acc + el
#     end
#   end
#   highest_sum
# end

def largest_contiguous_subsum(list)
  current_sum = [list.first]
  list.each_with_index do |el, i|
    next if i.zero?
    current_sum << current_sum.last + el
  end

  max = current_sum.max
  max_index = current_sum.find_index(max)
  highest_sum = list[max_index]

  temp_sum = 0#highest_sum
  while max_index >= 0
    max_index -= 1
    # debugger
    if highest_sum + list[max_index] > temp_sum
      highest_sum = highest_sum + list[max_index]
      temp_sum = highest_sum# + list[max_index]
    else
      break
    end
  end

  list.each do |el|
    highest_sum = el if el > highest_sum
  end

  highest_sum
end

list = [5, 3, -7]
p largest_contiguous_subsum(list)
list = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list)
list = [-5, -1, -3]
p largest_contiguous_subsum(list)
list = [7, -6, 7, -6, 3, 2]
p largest_contiguous_subsum(list)
