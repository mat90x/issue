#!/usr/bin/python3
"""
CtCI 1.7. Given an image represented by an NxN matrix, where each pixel in the
image is 4 bytes, write a method to rotate the image by 90 degrees. Can you do
this in place?
"""

matrix = []
n = int(input("enter n: "))
for i in range(n):
  row = input("enter row " + str(i+1) + ": ").split()
  if len(row) != n:
    print("you've entered wrong number of elements")
    quit()
  matrix.append(row)
if len(matrix) != n:
  print("you've entered wrong number of rows")
  quit()

def rotate_matrix1(m, n):
  new_matrix = []
  for x in range(n):
    row = []
    for y in range(n-1,-1,-1):
      row.append(m[y][x])
    new_matrix.append(row)
  return new_matrix

def rotate_matrix2(m, n):
  for layer in range(n//2):
    first = layer 
    last = n - 1 - layer
    for i in range(first, last):
      offset = i - first
      top = matrix[first][i]
      # cycling 
      matrix[first][i]           = matrix[last-offset][first]
      matrix[last-offset][first] = matrix[last][last-offset]
      matrix[last][last-offset]  = matrix[i][last]
      matrix[i][last]            = top

new_matrix = rotate_matrix1(matrix,n)
rotate_matrix2(matrix,n)
for i in range(n):
  print(' '.join(new_matrix[i]))
print("="*(2*n-1))
for i in range(n):
  print(' '.join(matrix[i]))
