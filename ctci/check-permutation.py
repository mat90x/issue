#!/usr/bin/python3
"""
CtCI 1.2. Given two strings, write a methid to decide if one is a permutation
of the other
"""
import sys

def is_permutation1(s1, s2):
  s1 = ''.join(sorted(s1))
  s2 = ''.join(sorted(s2))
  return s1 == s2

def is_permutation2(s1, s2):
  d1, d2 = {}, {}
  for c in s1:
    if c not in d1:
      d1[c] = 1
    else:
      d1[c] += 1
  for c in s2:
    if c not in d2:
      d2[c] = 1
    else:
      d2[c] += 1
  return d1 == d2

if is_permutation1(sys.argv[1], sys.argv[2]):
  print("first string is a permutation of second")

if is_permutation2(sys.argv[1], sys.argv[2]):
  print("first string is a permutation of second")
