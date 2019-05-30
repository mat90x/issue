#!lua
-- PiL 7.3. Write an iterator uniquewords that returns all words from a given
-- file without repetitions.

function unique_words ()
  local line = io.read()
  local pos = 1
  local dict = {}
  return function ()
    while line do
      local s, e = string.find(line, "%w+", pos)
      if s then
        pos = e + 1
        local word =  string.sub(line, s, e)
        if not dict[word] then
          dict[word] = true
          return word
        end
      else
        line = io.read()
        pos = 1
      end
    end
    return nil
  end
end

for word in unique_words() do
  print(word)
end
