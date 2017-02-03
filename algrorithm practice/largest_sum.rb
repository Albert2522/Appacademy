list1 = [5, 3, -7]
list2 = [2, 3, -6, 7, -6, 7]
list3 = [-5, -1, -3]



def largest_cont_sum(arr)
  i = 0
  start_index = 0
  stop_index = 0
  max = arr.first
  while i < arr.length
    j = i
    while j < arr.length
      max_curr = arr[i..j].inject(&:+)
      if max_curr > max
        max = max_curr
        start_index = i
        stop_index = j
      end
      j += 1
    end
    i += 1
  end
  arr[start_index..stop_index]
end

def include_positive?(arr)
  arr.any? { |el| el > 0 }
end

def largest_cont_sum2(arr)
  if include_positive?(arr)
    largest_cont_sum_positive(arr)
  else
    arr.max
  end
end

def largest_cont_sum_positive(arr) # O(n) time, O(1) memory
  max = 0
  temp_max = 0
  i = 0
  while i < arr.length
    temp_max += arr[i]
    temp_max = 0 if temp_max < 0
    max = temp_max if max < temp_max
    i += 1
  end
  max
end
# list1 = [5, 3, -7]
# list2 = [2, 3, -6, 7, -6, 7]
# list3 = [-5, -1, -3]


p largest_cont_sum2(list1)
p largest_cont_sum2(list2)
p largest_cont_sum2(list3)
