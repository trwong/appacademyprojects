class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = ""
    self.each do |el|
      if el.is_a?(Array)
        result += el.hash.to_s
      elsif el.is_a?(String)
        result += el.hash.to_s
      elsif el.is_a?(Fixnum)
        result += el.to_s
      end
    end
    result.to_i.hash
  end
end

class String
  def hash
    self.chars.map { |char| char.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
