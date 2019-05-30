#!lua
-- PiL 3.1. What will the following program print?

  for i = -10, 10 do
    print(i, i % 3)
  end

-- Lines of pairs of index and the result of the division of the index
-- by the modulus 3. Index will be in the range from -10 to 10 with step 1.


-- PiL 3.2. What is the result of the expression 2^3^4? What about 2^-3^4?
-- Exponentiation has greater priority and executed from right to left, unary
-- minus has smaller priority, so,
  2^3^4 == 2^(3^4) and
  2^-3^4 == 2^(-(3^4))


-- PiL 3.5. How can you check whether a value is a boolean without using the
-- type() function?
-- In Lua, comparison operator returns false if its operands have different
-- types, so that peculiarity can be exploited:
  a = 4
  print ( a == true or a == false ) ]]


-- PiL 3.6. Consider the following expression:

  (x and y and (not z)) or ((not y) and x)

-- Are the paretheses necessary? Would you recommend their use in that
-- expression?
-- There is no necessity for paretheses, because the negation operation is
-- performed the first, logical addition is performed the last, so,

(x and y and (not z)) or ((not y) and x) == x and y and not z or not y and x.

-- But with the paretheses the expression looks more clearer, so I would leave
-- it as is.


-- PiL 3.7. What will the following script print? Explain.

  sunday = "monday"; monday = "sunday"
  t = {sunday = "monday", [sunday] = monday}
  print(t.sunday, t[sunday], t[t.sunday])

-- In the first line the variables 'sunday' and 'monday' with values "monday"
-- and "sunday", respectively, are created.
-- In the second line table with keys 'monday' and 'sunday' with values
-- "monday" and "sunday", respectively, is created.
-- Finaly, last line prints "monday sunday sunday".


-- PiL 3.8. Suppose that you want to create a table that associates each escape
-- sequence for strings (see Section 2.4) with its meaning. How could you write
-- a constructor for that table?

  ec = { nwl="\n", tab="\t" }
  print("Here have to be "..ec.nwl.."newline and here is"..ec.tab
    .." a tabulation!")


-- PiL 4.1. Most languages with a C-like syntax do not offer an elseif
-- construct. Why does Lua need this construct more that those languages?
-- Because Lua hasn't the switch operator, without elseif there is no
-- convenient workaround to implement that particular operator.


-- PiL 4.3. Many people argue that repeat-until is seldom used, and therefore
-- it should not be present in a minimalistic language like Lua. What do you
-- think?
-- Because sometimes we need to check the condition after some operations have
-- been made. For example, we need to check in 'until' clause the results of
-- input, but check could have been done only after the io.read() call.


-- PiL 4.5. Can you explain why Lua has the restriction that a goto cannot jump
-- out of a function?
-- In Lua one cannot jump out of or into a block, because block of code has
-- local variable scope. If such jumping would have been allowed then after
-- each such jump the scope of variables would have been changed. At the low
-- level the funcion's local variables are stored in the execution stack and
-- each function call causes them to initialize time and time again.
-- So, jumps must occur within the same execution stack, goto cannot jump out
-- of or into a function.


-- PiL 4.6. Assuming that a goto could jump out of a function, explain what the
-- program in Listing 4.3 would do.

   1 function getlabel ()
   2   return function () goto L1 end
   3   ::L1::
   4   return 0
   5 end
   6
   7 function f (n)
   8   if n == 0 then return getlabel()
   9   else
  10     local res = f(n - 1)
  11     print(n)
  12     return res
  13   end
  14 end
  15
  16 x = f(10) 
  17 x()

-- The 16th line causes recursive f() calls that causes the assigning of '10'
-- to 'x', but 17th line contains the attempt of calling x() which is not
-- declared and thus the program crashes with error.


-- PiL 8.4. Can you find any value for f such that the call pcall(pcall, f)
-- returns false as its first result?

-- The call:

  pcall(pcall,(function() end)())

-- returns:

  false   bad argument #1 to 'pcall' (value expected)

-- The inner most call returns no value, which is different from returning nil.
-- And the inner pcall() falls with error which forces the outer pcall() return
-- 'false'.
