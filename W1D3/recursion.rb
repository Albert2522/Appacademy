
def range(start_idx, end_idx)

  return [end_idx] if end_idx == start_idx
  return [] if end_idx < start_idx

  [start_idx] + range(start_idx+1, end_idx)

end

#iterative version

def range2(start_idx, end_idx)
  return [] if end_idx < start_idx

  result = []

  while start_idx <= end_idx
    result << start_idx
    start_idx += 1
  end

  result
end

def recursion1(b,n)
  return 1 if n.zero?

  b * recursion1(b, n-1)
end

def recursion2(b,n)
  return 1 if n.zero?
  return b if n == 1

  if n % 2 == 0
    return recursion2(b, n/2) * recursion2(b, n/2)
  else
    b * (recursion2(b, (n-1)/2)**2)
  end
end


def deep_dup(object)
  if !object.is_a? Array
    return object.dup
  else
    arr = [ ]
    object.each { |el| arr << deep_dup(el)}
    arr
  end
end

def fib(n)
  return 0 if n <= 0
  return 1 if n == 1
  fib(n - 1) + fib(n - 2)
end

def fib_iter(n)
  arr = [0, 1]

  (2..n).each do |idx|
    arr << (arr[idx-2] + arr[idx-1])
  end

  arr[n]
end

def subsets(arr)
  return [[]] if arr.size == 0
  return [[], [arr.last]] if arr.size == 1
  return [[], [arr.first], [arr.last]] if arr.size == 2
  tmp = [ ]
  tmp1 = subsets(arr[0..-2])
  tmp1.each do |sub_arr|
    tmp << sub_arr + [arr.last]
  end
  tmp1 + tmp + [arr]
end


# def permutations(array)
#   return [[[array.first]]] if start_index
#
#   [array] + [rotate_array(array)]
# end
#
#
# def rotate_array(array)
#   rotated_array = []
#   array.each_with_index do |el, i|
#
#     rotate_letter = el
#     rest_of_array = array[(i+1)..-1]
#
#     (rest_of_array.length - 1).times do
#       rotated_array << ([el] + [permutations(rest_of_array.rotate)])
#     end
#   end
#   rotated_array
# end

# def helper(arr, start_index)
#   if start_index >= arr.size - 1
#     p arr
#   else
#     i = start_index
#     while i < arr.length
#       arr[start_index],arr[i] = arr[i],arr[start_index]
#       helper(arr, start_index + 1)
#       arr[i],arr[start_index] = arr[start_index],arr[i]
#       i += 1
#     end
#   end
# end

def change(arr)
  [arr, arr.rotate]
end

def permutations(array)
  return change(array) if array.length == 2
  old_perm = permutations(array[0..-2])
  answer = [ ]
  old_perm.each do |arr|
    i = 0
    l = arr.length
    c = array.last
    while i <= l
      arr1 = arr.dup
      arr1.insert(i, c)
      answer << arr1
      i += 1
    end
  end
  answer
end

# (0..old.perm.length).times do |i|
# permutations(old_perm[0..i]) + array.last + permutations(old_perm[i..-1])
#
# def bsearch(arr, target)
#   helper(arr, target, )
# end

def bsearch(arr, target)
  return nil if arr.empty?
  l = arr.length / 2
  if target == arr[l]
    return l
  elsif target > arr[l]
    val = bsearch(arr[l + 1..-1], target)
    return l + val + 1 if val
    val
  else
    bsearch(arr[0...l], target)
  end
end

def merge_arrays(a, b)
  arr = [ ]
  i = 0
  j = 0
  while i < a.length && j < b.length
    if a[i] <  b[j]
      arr.push(a[i])
      i += 1
    else
      arr.push(b[j])
      j += 1
    end
  end
  while i < a.length
    arr.push(a[i])
    i += 1
  end
  while j < b.length
    arr.push(b[j])
    j += 1
  end
  arr
end

def merge_sort(arr)
  return [] if arr.empty?
  return [arr.last] if arr.size == 1
  mid = arr.size / 2 - 1
  p mid
  merge_arrs(merge_sort(arr[0..mid]), merge_sort(arr[mid + 1 .. -1]))
end

def merge_arrs(array1, array2)
  ret_array = []

  until array1.empty? && array2.empty? ##use indexes to add to array
    if array1.first < (array2.first || array1.max + 1)
      ret_array << array1.shift
    else
      ret_array << array2.shift
    end
  end

  ret_array
end

def greedy_make_change(amt, coins = [25, 10, 5, 1])
  return [] if amt == nil
  possible_coins = coins.reject { |coin| coin > amt }
  biggest_coin = possible_coins[0]
  num_of_biggest_coin = amt/biggest_coin

  Array.new(num_of_biggest_coin, biggest_coin) + greedy_make_change(amt % biggest_coin)
end

def greedy_greedy(value, coins = [25, 10 ,5 ,1])
  return [] if value == 0
  i = 0
  while i < coins.length
    if coins[i] <= value
      return [coins[i]] + greedy_greedy(value - coins[i], coins)
    end
    i += 1
  end
end

def greedy(value, coins = [25, 10 ,5 ,1])
  return [] if value == 0
  answer = Array.new(10, 0)
  coins.each do |coin|
    if coin <= value
        sub_res = greedy(value - coin, coins)
        if sub_res.size + 1 < answer.size
          answer = sub_res + [coin]
        end
    end
  end
  answer
end
