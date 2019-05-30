#!lua
-- PiL 3.3. We can represent a polynomial in Lua as a list of its coefficients.
-- Write a function that receives a polynomial (represented as a table) and a
-- value for x and returns the polynomial value.

function polynomial(coeffs, x)
  sum = 0
  for i = 1, #coeffs do
    sum = sum + coeffs[i] * x ^ (i-1)
  end
  return sum
end


-- PiL 3.4. Can you write the function from the previous item so that it uses
-- at most n additions and n multiplications (and no exponentiations)?

function polynomial_add_mult(coeffs, x)
  sum = 0
  for i = 1, #coeffs do
    arg = 1
    for j = 1, i-1 do
      arg = arg * x
    end
    sum = sum + coeffs[i] * arg
  end
  return sum
end

function polynomial_to_str(coeffs, x) -- for convenience
  str = ""
  if #coeffs ~= 0 then
    str = coeffs[1].."*"..x.."^0"
  else
    return ""
  end
  for i = 2, #coeffs do
    str = str.." + "..coeffs[1].."*"..x.."^"..i
  end
  return str
end


-- PiL 6.2. Write the curried version of the function from PiL 3.3. The
-- function should receive a polynomial and returns a function that, when
-- called with a value for x , returns the value of the polynomial for that x.
-- See the example:
-- f = newpoly({3, 0, 1})
-- print(f(0))  --> 1
-- print(f(5))  --> 76
-- print(f(10)) --> 301

function newpoly(coeffs)
  return function(x)
    sum = 0
    for i = 1, #coeffs do
      sum = sum + coeffs[i] * x^(i-1)
    end
    return sum
  end
end


print("Polynomial: "      ..polynomial_to_str({1,2,3},2))
print("Generic: "         ..polynomial({1,2,3}, 2))
print("Add and multiple: "..polynomial_add_mult({1,2,3}, 2))

f = newpoly({1,2,3})
print("Curried version: "..f(2))
