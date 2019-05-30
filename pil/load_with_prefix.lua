#!lua
-- PiL 8.1. Frequently, it is useful to add some prefix to a chunk of code when
-- loading it. Write a function loadwithprefix() that works like load, except
-- that it adds its extra first argument (a string) as a prefix to the chunk
-- being loaded.
-- Like the original load(), loadwithprefix() should accept chunks represented
-- both as strings and as reader functions. Even in the case that the original
-- chunk is a string, loadwithprefix() should not actually concatenate the
-- prefix with the chunk. Instead, it should call load with a proper reader
-- function that first returns the prefix and then returns the original chunk.


-- PiL 8.2. Write a function multiload that generalizes loadwithprefix by
-- receiving a list of readers, as in the following example:

-- f = multiload("local x = 10;",
-- io.lines("temp", "*L"),
-- " print(x)")

-- For the above example, multiload should load a chunk equivalent to the
-- concatenation of the string “ local... ” with the contents of the temp file
-- with the string “ print(x) ”. Again, like function loadwithprefix from the
-- previous exercise, multiload should not actually concatenate anything.

function load_with_prefix(prefix, code)
  local is_prefix_read, is_code_read = false, false
  local function reader()
    if not is_prefix_read then
      is_prefix_read = true
      return prefix
    elseif not is_code_read then
      if type(code) == "function" then
        return code()
      else
        is_code_read = true
        return code
      end
    end
    return nil
  end
  return load(reader, "load_with_prefix", "t")
end

function reader(arg)
  local i = 0
  return function()
    i = i + 1
    return arg[i]
  end
end

f = load_with_prefix("return ", "8 + 2 - 13 + 5^2")
print("Load with string prefix: " .. f())

f = load_with_prefix("return ", reader{'5', '-7', '+3', '+2*4'})
print("Load with function prefix: " .. f())
