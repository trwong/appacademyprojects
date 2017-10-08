require 'byebug'

def range(start, fin)
  return [] if fin < start || start == fin
  [start] + range(start + 1, fin)
end

p range(1,5) == [1,2,3,4]

def range_iterative(start,fin)
  result = []
  (start...fin).to_a.each { |el| result << el }
end

p range_iterative(1,5) == [1,2,3,4]

def exp(b, n)
  return 1 if n == 0
  b * exp(b, n-1)
end

p exp(2, 3) == 8
p exp(3, 4) == 81

def exp1(b,n)
  return 1 if n == 0
  if n.even?
    result = exp1(b, n / 2)
    result * result
  else
    result = exp1(b, (n - 1) / 2)
    b * result * result
  end
end

p exp1(2, 3) == 8
p exp1(3, 4) == 81

class Array
  def deep_dup
    self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
  end
end

robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy = robot_parts.deep_dup

# shouldn't modify robot_parts
robot_parts_copy[1] << "LEDs"
# but it does
p robot_parts[1] == ["capacitors", "resistors", "inductors"]

def iter_fib(n)
  return [1] if n == 1
  result = [1,1]
  until result.length >= n
    result << result[-1] + result[-2]
  end
  result
end

p iter_fib(10) == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

def recur_fib(n)
  return [1] if n == 1
  return [1,1] if n == 2
  fib_arr = recur_fib(n - 1)
  fib_arr + [fib_arr[-1] + fib_arr[-2]]
end

p recur_fib(10) == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]


def subsets(arr)
  return [[]] if arr.empty?

end

# p subsets([]) #== [[]]
# p subsets([1]) #== [[], [1]]
# p subsets([1, 2]) #== [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3]) #== [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def permutation(array)
end

def bsearch(search_arr, search_item)
  return nil if search_arr.empty?
  mid = search_arr.length / 2
  left = search_arr[0...mid]
  right = search_arr[mid + 1..-1]
  case search_item <=> search_arr[mid]
  when 0
    return mid
  when -1
    bsearch(left, search_item)
  when 1
    search  =bsearch(right, search_item)
    search + mid + 1 if search
  end
end

p bsearch([1, 2, 3], 1) == 0
p bsearch([2, 3, 4, 5], 3) == 1
p bsearch([2, 4, 6, 8, 10], 6) == 2
p bsearch([1, 3, 4, 5, 9], 5) == 3
p bsearch([1, 2, 3, 4, 5, 6], 6) == 5
p bsearch([1, 2, 3, 4, 5, 6], 0) == nil
p bsearch([1, 2, 3, 4, 5, 7], 6) == nil

def merge_sort(arr)
  return arr if arr.length <= 1
  mid = arr.length / 2
  left = merge_sort(arr.take(mid))
  right = merge_sort(arr.drop(mid))
  merge(left, right)
end

def merge(arr1, arr2)
  result = []
  until arr1.empty? or arr2.empty?
    case arr1 <=> arr2
    when -1
      result << arr1.shift
    when 0
      result << arr1.shift
    when 1
      result << arr2.shift
    end
  end
  result + arr1 + arr2
end

arr = [1,2,3,4,5].shuffle
p merge_sort(arr) == arr.sort

def greedy_make_change(amount, coins = [25,10,5,1])
end

def make_better_change(amount = 24, coins = [10,7,1])
end
