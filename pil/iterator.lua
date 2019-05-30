#!lua
-- PiL 7.1. write an iterator 'fromto' such that the next two loops become
-- equivalent:

-- for i in fromto(n, m)
--   <body>
-- end

-- for i = n, m
--   <body>
-- end

-- Can you implement it as a stateless iterator?


-- PiL 7.2. Add a step parameter to the iterator. Can you still implement it as
-- a stateless iterator?

function fromto(n, m, step)
  step = step or 1
  local i = n - step
  return function()
    if i < m then
      i = i + step
      return i
    else
      return nil
    end
  end
end

for i in fromto(1,5,2) do
  print(i)
end

f = fromto(1,5,2)
print(f())
print(f())
print(f())
