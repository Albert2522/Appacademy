def windowed_max_range(arr, number)
  queue = []
  i = 0
  while i < number
    queue.push(arr[i])
    i += 1
  end
  raise "error" if queue.size < number
  i = number
  temp_max = queue.max
  temp_min = queue.min
  temp_max2 = (queue - [temp_max]).max
  temp_min2 = (queue - [temp_max]).min
  max_diff = temp_max - temp_min
  while i < arr.length
    p queue
    tmp = queue.shift
    temp_max = temp_max2 if temp_max == tmp
    temp_min = temp_min2 if temp_min == tmp
    temp_max = arr[i] if arr[i] > temp_max
    temp_min = arr[i] if arr[i] < temp_min
    diff = temp_max - temp_min
    max_diff = diff if diff > max_diff
    queue.push(arr[i])
    i += 1
  end
  max_diff
end



puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) #== 4
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4)#== 6
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6
