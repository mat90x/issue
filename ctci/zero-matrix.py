#!/usr/bin/python3
"""
CtCI 1.8. Write an algorithm such that if an element in an MxN matrix is 0 its
entire row and column are set to 0.
"""

matrix = []
m, n = input("enter m and n: ").split()
m = int(m)
n = int(n)
for i in range(m):
  row = input("enter row " + str(i+1) + ": ").split()
  if len(row) != n:
    print("you've entered wrong number of elements")
    quit()
  matrix.append(row)
if len(matrix) != m:
  print("you've entered wrong number of rows")
  quit()

rows_to_nullify = []
cols_to_nullify = []
for y in range(m):
  for x in range(n):
    if matrix[y][x] == '0':
      if y not in rows_to_nullify:
        rows_to_nullify.append(y)
      if x not in cols_to_nullify:
        cols_to_nullify.append(x)

for i in rows_to_nullify:
  matrix[i] = ['0' for i in matrix[i]]
for i in range(m):
  for row in rows_to_nullify:
    matrix[i][row] = '0'

for i in range(m):
  print(' '.join(matrix[i]))
