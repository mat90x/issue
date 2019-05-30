#!lua
-- PiL 5.2: Write a function that receives an array and prints all elements in
-- that array. Consider the pros and cons of using table.unpack in this
-- function.

function print_arr(arr)
  for i = 1, #arr do
    print(arr[i])
  end
end

function print_arr2(arr)
  print(table.unpack(arr))
end

function print_arr3(arr)
  local arr = {table.unpack(arr)}
  for i = 1, #arr do
    print(arr[i])
  end
end

print_arr({1,2,3,4,5})

print_arr2({7,8,9})

print_arr3({element=6,3,2})
