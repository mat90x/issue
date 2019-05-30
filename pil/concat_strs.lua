#!lua
-- PiL 5.1. Write a function that receives an arbitrary number of strings and
-- returns all of them concatenated together.

function concat_strs(...)
  local concat_strs = ""
  for _, v in ipairs{...} do
    concat_strs = concat_strs .. v
  end
  return concat_strs
end

function concat_strs2(...)
  local concat_strs = ""
  local arr = table.pack(...)
  for i = 1, arr.n do
    concat_strs = concat_strs .. arr[i]
  end
  return concat_strs
end

function concat_strs3(...)
  local concat_strs = ""
  local arr = {...}
  for i = 1, #arr do
    concat_strs = concat_strs .. arr[i]
  end
  return concat_strs
end

print(concat_strs("This string should look like ", "a whole!"))
print(concat_strs2(
  "Here is another example that ", "looks like ", "a whole string!"))
print(concat_strs3(
  "And yet another string ", "that looks like ", "a whole!"))
