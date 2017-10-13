require 'byebug'

def range(start, fin)
  return nil if fin < start
  return [fin -1] if start == fin - 1
  [start] + range(start + 1, fin)
end



def range_iterative(start,fin)
  arr = []
  (start...fin).each{|n| arr << n }
  arr
end

def exp(b, n)
  return 1 if n == 0
  return nil if n < 0

  return b * exp(b,n-1)

end

def exp1(b,n)
  return 1 if n == 0
  return nil if n < 0
  return b if n == 1
  if n.even?
    calc = exp1(b, n / 2)
    return calc * calc
  else
    calc2 =exp1(b, (n - 1) / 2)
    b * calc2 * calc2
  end
end

class Array
  def deep_dup
    arr = []
    self.each do |el|
      if el.is_a?(Array)
        arr << el.deep_dup
      else
        arr << el
      end
    end
    arr
  end
end

def iter_fib(n)
  arr = [1, 1]
  until arr.length >= n
    arr << arr[-1] + arr[-2]
  end
  arr
end

def recur_fib(n)
  return nil if n <= 0
  return [1] if n == 1
  return [1,1] if n == 2
  # p recur_fib(n - 2)[-1]
  # p recur_fib(n - 1)[-1]
  fib = recur_fib(n - 1)
  fib + [recur_fib(n - 2)[-1] + fib[-1]]
end

# p recur_fib(25) == iter_fib(25)


# def subsets(arr)
#   return [] if arr == []
#   answer_arr = []
#   arr.each_with_index do |el, idx|
#     p arr.delete_at(idx)
#     answer_arr << subsets([arr.delete_at(idx)])
#   end
#   answer_arr.uniq
# end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])

class Array
  def subsets
    return [] if self.empty?
    answer_arr = [self]

    self.each_index do |i|
      subvar = (self - [self[i]]).subsets
      if subvar == []
        answer_arr << subvar
      else
        answer_arr += subvar
      end
    end
    answer_arr.uniq.sort
  end
end

# p [].subsets
# p [1,2,3].subsets

def permutation(array)
  answer_arr = []
  return array if array.length == 1
  array.each_index do |i|
    perm = permutation(array - [array[i]])
    perm.each do |el|
      answer_arr << ([array[i]] + [el]).flatten
    end
    perm.each do |el|
      answer_arr << ([el] + [array[i]]).flatten
    end
  end
  answer_arr.uniq
end

def bsearch(search_arr, search_item)
  if search_arr.length.odd?
    mid = search_arr.length / 2
  else
    mid = (search_arr.length / 2) - 1
  end
  return mid if search_arr[mid] == search_item
  return nil if search_arr.length == 1
  if search_arr[mid] > search_item
    bs = bsearch(search_arr[0..mid], search_item)
    if bs == nil
      return nil
    else
      return bs - mid + 1
    end
  else
    bs = bsearch(search_arr[mid+1..-1], search_item)
    if bs == nil
      return nil
    else
      return bs  + mid + 1
    end
  end
end

def merge_sort(arr)
  return arr if arr.length == 1
  if arr.length.odd?
    mid = arr.length / 2
  else
    mid = (arr.length / 2) - 1
  end

  merge(merge_sort(arr[0..mid]), merge_sort(arr[mid + 1..-1]))
end

def merge(arr1, arr2)
  sorted_arr = []
  total_length = arr1.length + arr2.length
  until sorted_arr.length == total_length
    # byebug
    if arr2.empty? || arr2.nil?
      sorted_arr << arr1.shift
    elsif arr1.empty? || arr1.nil?
      sorted_arr << arr2.shift
    elsif arr1.first < arr2.first
      sorted_arr << arr1.shift
    elsif arr2.first <= arr1.first
      sorted_arr << arr2.shift
    end
  end
  sorted_arr
end

p merge_sort([38, 27, 43, 3, 9, 82, 10])

def greedy_make_change(amount, coins = [25,10,5,1])
  return nil if amount <= 0
  wallet_arr = []
  mycoin = coins

  until mycoin.first <= amount
    mycoin.rotate!
  end

  wallet_arr += [mycoin.first] + [greedy_make_change(amount - mycoin.first, coins)]

  wallet_arr.flatten.compact
end

# p greedy_make_change(99)

def make_better_change(amount = 24, coins = [10,7,1])
  return 0 if amount <= 0
  wallet_arr = []
  mycoin = coins
  until mycoin.first <= amount
    mycoin.shift
  end
  largest_coin = mycoin[0] || coins.last
  next_largest_coin = mycoin[1] || coins.last

  large_recurve = [make_better_change(amount - largest_coin, mycoin)]
  next_recurve = [make_better_change(amount - next_largest_coin, mycoin - [largest_coin])]

  smallest = large_recurve.length > next_recurve.length ? next_recurve : large_recurve
  past_coin = large_recurve.length > next_recurve.length ? next_largest_coin : largest_coin

  wallet_arr += [past_coin] + [smallest]
  wallet_arr.flatten.compact
end


p make_better_change(24, [10,7,1])
