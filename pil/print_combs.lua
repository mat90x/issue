#!lua
-- PiL 5.4: Write a function that receives an array and prints all combinations
-- of the elements in the array.

combs = {}
combn = 1

function print_combs(arr)
  if #arr == 1 then
    return arr[#arr]
  else
    local arr = {select(2,table.unpack(arr))}
    return arr[#arr] .. print_combs(arr)
  end
end

print(print_combs({1,2,3,4,5}))
