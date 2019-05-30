#!lua

function permgen (a, n)
  n = n or #a
  if n <= 1 then
    print(a)
  else
    for i = 1, n do
      a[n], a[i] = a[i], a[n]
      permgen(a, n - 1)
      a[n], a[i] = a[i], a[n]
    end
  end
end

permgen({1,2,3})
