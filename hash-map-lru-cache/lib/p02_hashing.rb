class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    answer = 0.hash
    each_with_index do |el, i|
      el1 = (el.is_a?(String) ? el.ord % 13 : el)
      answer += el1.hash if i.odd?
      answer -= el1.hash if i.even?
    end
    answer
  end
end

class String
  def hash
    self.chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    answer = 0.hash
    keys.each do |key|
      el = key.to_s.hash
      answer ^= el
    end
    answer
  end
end
