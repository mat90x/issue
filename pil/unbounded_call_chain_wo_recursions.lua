#!lua
-- PiL 6.3. Sometimes, a language with proper-tail calls is called properly
-- tail recursive, with the argument that this property is relevant only when
-- we have recursive calls. (Without recursive calls, the maximum call depth of
-- a program would be statically fixed.)
-- Show that this argument does not hold in a dynamic language like Lua: write
-- a program that performs an unbounded call chain without recursion.

-- load() loads a chunk. And if the argument is a function, load() calls it
-- repeatedly to get the chunk pieces. Each call to the argument must return a
-- string that concatenates with previous results. A return of an empty string,
-- nil, or no value signals the end of the chunk.
-- Since `load` will repeatedly calls a function, we can use it to build an
-- unbounded call chain with random numbers.

n = math.random(123456789)

function f ()
  n = n - 1
  if n < 0 then
    return nil
  else
    return 'i = 1;'
  end
end 

load(f)()
