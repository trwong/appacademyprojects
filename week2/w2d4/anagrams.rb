def first_anagram?(string, target)
  string.chars.permutation.to_a.map{|chars| chars.join("")}.include?(target)
end

# p first_anagram?("gizmo", "sally")
# p first_anagram?("elvis", "lives")

def second_anagram?(string, target)
  string.each_char do |str_ch|
    if target.include?(str_ch)
      string.delete!(str_ch)
      target.delete!(str_ch)
    end
  end

  string.length == 0 && target.length == 0
end

def third_anagram?(string, target)
  string_ch = string.chars.sort
  target_ch = target.chars.sort
  string_ch == target_ch
end

def fourth_anagram?(string, target)
  string_hash = Hash.new(0)
  target_hash = Hash.new(0)

  string.each_char{|ch| string_hash[ch] += 1}
  target.each_char{|ch| target_hash[ch] += 1}

  string_hash == target_hash
end

p fourth_anagram?("gizmo", "sally")
p fourth_anagram?("elvis", "lives")
