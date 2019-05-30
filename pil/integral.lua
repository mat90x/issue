#!lua
-- PiL 6.1: Write a function integral that receives a function f and returns an
-- approximation of its integral.

function integral(f, x1, x2, delta)
  delta = delta or 1e-4
  local integral = 0
  for i = x1, x2, delta do
    integral = integral + delta * f ( (2*i + delta)/2 )
  end
  return integral
end

print("integral(f(x) = 1, 1, 5) = "
    ..string.format( "%.4f", integral(function(x) return 1 end, 1, 5)))
print("integral(f(x) = x + 1, 1, 5) = "
    ..string.format( "%.4f", integral(function(x) return x+1 end, 1, 5)))
print("integral(f(x) = x^2, 1, 5) = "
    ..string.format( "%.4f", integral(function(x) return x^2 end, 1, 5)))
print("integral(f(x) = 1/x, 1, 5) = "
    ..string.format( "%.4f", integral(function(x) return 1/x end, 1, 5)))
print("integral(f(x) = x^3, 1, 5) = "
    ..string.format( "%.4f", integral(function(x) return x^3 end, 1, 5)))
