def anagram?(word1, word2) # O(n!)
  word1.chars.permutation.map(&:join).include?(word2)
end

def second_anagram?(word1, word2) # O(n^2)
  return false unless word1.length == word2.length
  word1.chars.each { |letter| word2.sub!(letter, "") }
  word2.empty?
end

def third_anagram?(word1, word2) # O(nlogn)
  word1.chars.sort == word2.chars.sort
end

def pop_hash(word) # O(n)
  hash = {}
  word.chars.each do |letter|
    hash.key?(letter) ? hash[letter] += 1 : hash[letter] = 1
  end
  hash
end

def fourth_anagram?(word1, word2) # O(n)
  hash1 = pop_hash(word1)
  hash2 = pop_hash(word2)
  hash1 == hash2
end

def fifth_anagram?(word1, word2) # O(n)
  hash = pop_hash(word1)
  word2.chars.each do |letter|
    return false if !hash.key?(letter) || hash[letter] - 1 < 0
    hash[letter] -= 1
  end
  true
end

puts fifth_anagram?("gizmo", "sally")  == false
puts fifth_anagram?("elvis", "lives")  == true
