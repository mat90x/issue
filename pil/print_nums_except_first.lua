#!lua
-- PiL 5.3. Write a function that receives an arbitrary number of values and
-- returns all of them, except the first one.

function print_nums_except_first(...)
  local nums = {...}
  for i = 2, #nums do
    print(nums[i])
  end
end

function print_nums_except_first2(...)
  for _, v in ipairs({select(2,...)}) do
    print(v)
  end
end

print_nums_except_first(1,2,3,4,5)

print_nums_except_first2(7,8,9)
