#!lua
-- PiL 7.4: Write an iterator that returns all non-empty substrings of a given
-- string.

function substrings(str)
  local from = 1
  local to = 0
  local length = #str
  return function()
    to = to + 1
    if to > length then
      from = from + 1
      to = from
    end
    local substring = string.sub(str, from, to)
    if #substring ~= 0 then
      return substring
    else
      return nil
    end
  end
end

for str in substrings("abcdefg") do
  print(str)
end
