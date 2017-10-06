# require_relative 'dictionary'
require 'set'

class WordChainer

  attr_accessor :dictionary, :current_words, :all_seen_words

  def initialize
    @dictionary = File.readlines('dictionary.txt').map(&:chomp).to_set
    # p @dictionary
  end

  def adjacent_words(word)
    arr = []

    word.chars.each_index do |idx|
      arr +=  @dictionary.select do |dic|
          dic.length == word.length && word[0...idx] == dic[0...idx] && word[idx+1..-1] == dic[idx+1..-1]
        end
    end
    arr
  end

  def run(source,target)
    @current_words = [source]
    @all_seen_words = [source]

    until @current_words.empty?
      if @current_words.include?(target)
        return target
      end
      new_current_words = Set.new
      @current_words = explore_current_words(target, new_current_words)
      p @current_words
    end
  end

  def explore_current_words(target, new_current_words)
    @current_words.each do |word|
      adjacent_words(word).each do |adj|
        if @all_seen_words.include?(adj)
          next
        else
          new_current_words << adj
          @all_seen_words << adj
        end
      end
    end
    new_current_words
  end

end

a = WordChainer.new()
# # p a.dictionary.include?('yardstick')
# p a.adjacent_words('cat')

p a.run('duck', 'ruse')
