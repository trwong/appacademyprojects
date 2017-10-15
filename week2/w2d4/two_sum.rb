def bad_two_sum?(array, target_sum)
  array.each_with_index do |el, i|
    array.each_with_index do |el2, j|
      return true if el + el2 == target_sum && j != i
    end
  end
  false
end



def okay_two_sum?(array, target_sum)
  array.sort!
  start_i = 0
  end_i = array.length - 1
  until start_i == end_i
    if array[start_i] + array[end_i] == target_sum
      return true
    elsif array[start_i] + array[end_i] > target_sum
      end_i -= 1
    else
      start_i += 1
    end
  end
  false
end

# =begin
arr = [0, 7, 5, 1]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false
# =end

def two_sum?(array, target_sum)
  hash = Hash.new(0)
  array.each { |el| hash[el] += 1}
  hash.each do |k, _|
    if hash[target_sum - k] > 0
      if hash[target_sum - k] < 2 && target_sum - k != k || hash[target_sum - k] > 1
        return true
      end
    end
  end
  false
end

arr = [0, 7, 5, 1]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false
