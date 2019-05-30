#!/usr/bin/python3
"""
CtCI 1.1. Implement an algorithm to determine if a string has all unque
characters. What if you cannot use additional data structures?
"""
import sys
characters = {}
for c in sys.argv[1]:
  if c in characters:
    print("the string has non-unique characters!")
    break
  else:
    characters[c] = c

for i, c in enumerate(sys.argv[1]):
  if sys.argv[1].find(c, i+1) >= 0:
    print("the string has non-unique characters!")
    break
