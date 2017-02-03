def bad_two_sum?(arr, target_sum) # O(n^2)
  i = 0
  flag = false
  while i < arr.length
    j = i + 1
    while j < arr.length
      flag = true if arr[i] + arr[j] == target_sum
      j += 1
    end
    i += 1
  end
  flag
end


def binary_search(arr, el)
  return false if arr.empty?
  mid = arr.size / 2
  return true if el == arr[mid]
  if (el > arr[mid])
    binary_search(arr[mid + 1..-1], el)
  elsif (el < arr[mid])
    binary_search(arr[0...mid], el)
  else
    return false
  end
end

def ok_two_sum?(arr, target_sum)  # O(n log(n))
  arr.sort.any? { |n| binary_search(arr - [n], target_sum - n) }
end

def pop_hash(arr) # O(n)
  hash = {}
  arr.each do |number|
    hash.key?(number) ? hash[number] += 1 : hash[number] = 1
  end
  hash
end

def two_sum?(arr, target_sum)
  hash = pop_hash(arr)
  arr.sort.any? do |n|
    hash[n] -= 1 if hash.key?(target_sum - n)
    hash[target_sum - n] > 0 if hash.key?(target_sum - n)
  end
end

def any_sum?(arr, target, numbers)
  return false if numbers < 2
  if numbers == 2
    return two_sum?(arr, target)
  else
    arr.each_with_index do |el, i|
      arr.delete_at(i)
      answer = any_sum?(arr, target - el, numbers - 1)
      return answer if answer == true
    end
  end
  false
end

arr = [0, 1, 5, 7]
puts any_sum?(arr, 6, 3) == true
puts any_sum?(arr, 10, 3) == false
