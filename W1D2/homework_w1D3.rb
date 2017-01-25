def sum_to(n)
  if n == 1
    return n
  elsif n < 0
    return nil
  else
    return n + sum_to(n - 1)
  end
end

def add_numbers(array)
  if array.size == 1
    return array.last
  elsif array.empty?
    return nil
  else
    array.last + add_numbers(array[0..-2])
  end
end

def gamma_fnc(num)
  if num == 1 || num == 2
    return 1
  elsif num == 0
    return nil
  else
    return (num - 1) * gamma_fnc(num - 1)
  end
end

puts sum_to(5)   ==  15
puts sum_to(1)   ==  1
puts sum_to(9)   ==  45
puts sum_to(-8)  ==  nil
puts
puts add_numbers([1, 2, 3, 4]) ==  10
puts add_numbers([3]) ==  3
puts add_numbers([-80, 34, 7]) ==  -39
puts add_numbers([])  ==  nil
puts
puts gamma_fnc(0)   ==  nil
puts gamma_fnc(1)   ==  1
puts  gamma_fnc(4)   ==  6
puts  gamma_fnc(8)   ==  5040
