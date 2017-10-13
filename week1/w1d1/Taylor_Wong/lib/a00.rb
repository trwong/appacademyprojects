# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  answer = ""
  str.chars.each do |letter|
    if letter == " "
      answer << " "
    elsif letter.ord + shift > 122
      answer << (letter.ord + shift - 122 + 96).chr
    else
      answer << (letter.ord + shift).chr
    end
  end
  answer
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

# Example:
# digital_root(4322) => 2
# (4 + 3 + 2 + 2) => 11 => (1 + 1) => 2

def digital_root(num)
  if num < 10
    return num
  else
    digital_root(digital_root_step(num))
  end
end

def digital_root_step(num)
  sum = 0
  tens = 1
  tens *= 10 until tens > num
  while tens >= 10
    p sum
    sum += (num % tens) / (tens / 10)
    tens /= 10
  end
  sum
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  alphabet ||= ("a".."z").to_a
  hash = {}
  alphabet.each_with_index do |el, i|
    hash[el] = i
  end
  str.chars.sort_by { |el| hash[el] }.join("")
end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    answer = []
    for i in 0...self.length - 1
      for j in (i + 1)...self.length
        if (self[i] + self[j]).zero?
          answer << [i, j]
        end
      end
    end
    answer
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    answer = []
    for i in 0...self.length
      for j in i...self.length
        answer << self[i..j] if dictionary.include?(self[i..j])
      end
    end
    answer.uniq
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  (1..num).select { |el| (num % el).zero? }
end
