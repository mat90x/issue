#!/usr/bin/python3
"""
CtCI 1.4. Given a string, write a function to check if is a permutation of a
palindrome. A palindrome is a word or phrase thath is the same forwards and
backwards. A permutation is a rearrangement of letters. The palindrome does not
need to be limited to just dictionary words.
"""
import sys

def is_palindrome_permutation(s):
  d = {}
  for c in s:
    if c not in d:
      d[c] = 1
    else:
      del d[c]
  return len(d) <= 1

if is_palindrome_permutation(sys.argv[1]):
  print("string is a palindrome permutation")
