#!lua
-- PiL 1.1. Run the factorial example. What happens to your program if you
-- enter a negative number? Modify the example to avoid this problem.

function fact(n)
  if n < 0 then
    -- without this chunk the execution stack will be overflowed
    return "Negative number!"
  end
  if n == 0 then
    return 1
  else
    return n * fact(n-1)
  end
end

io.write("enter the number: ") 
a = io.read("*n")
print(fact(a))  
