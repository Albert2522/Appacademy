list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#  my_min(list)  # =>  -5

def my_min(list) #O(n^2)
  list.each do |el1|
    flag = false
    list.each do |el2|
      flag = true if el2 < el1
    end
    return el1 if flag == false
  end
end



def my_min2(list) #O(n)
  min = list.first
  list.each do |el|
    min = (el < min ? el : min)
  end
  min
end

p my_min2(list)
