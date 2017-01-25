require 'byebug'
class Array

def my_each(&prc)
  i = 0
  while i < self.length
    prc.call(self[i])
    i += 1
  end
  self
end

def my_select(&prc)
  output = []
  self.my_each { |elem| output << elem if prc.call(elem) == true}
  output
end

def my_reject(&prc)
  output = [ ]
  self.my_each { |elem| output << elem if prc.call(elem) == false}
  output
end

def my_any?(&prc)
  self.my_each {|elem| return true if prc.call(elem) == true}
  false
end

def my_all?(&prc)
  self.my_each {|elem| return false if prc.call(elem) != true}
  true
end

def my_flatten
  ans = [ ]
  self.each do |elem|
    if elem.is_a? Array
      ans += (elem.my_flatten)
    else
      ans.push(elem)
    end
  end
  ans
end

def my_zip(*args)
  prime_length = self.length
  output = []
  i = 0
  while i < self.length
    temp = []
    temp << self[i]
    j = 0
    while j < args.length
      temp << args[j][i]
      j += 1
    end
    i += 1
    output << temp
  end
  output
end

def my_rotate(shift=nil)
  shift = 1 if shift == nil
  a = self.dup
  if shift < 0
    shift = - shift
    flag = 1
  end
  ans = ""
  if flag != nil
    shift.times do
      el = a.pop
      a.unshift(el)
      p a
    end
  else
    shift.times do
      el = a.shift
      a.push(el)
      p a
    end
  end
  puts "____________________"
  p a
end

def my_join(sep="")
  results = ""
  idx = 0
  while idx < self.length
    results << self[idx]
    results << sep if idx != self.length - 1
    idx += 1
  end
  results
end

def my_reverse
  arr = [ ]
  j = self.size - 1
  while j >= 0
    arr.push(self[j])
    j -= 1
  end
end

end

puts [ "a", "b", "c" ].my_reverse   == ["c", "b", "a"]
puts [ 1 ].my_reverse               == [1]
