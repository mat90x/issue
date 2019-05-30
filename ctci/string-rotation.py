#!/usr/bin/python3
"""
CtCI 1.9. Assume you have a method isSubstring which checks if one is a
substring of another. Given two strings, s1 and s2, write code to check if s2
is a rotation of s1 using only one call to isSubstring (e.g., "waterbottle" is
a rotation of "erbottlewat").
"""
import sys

def is_substring(t, s):     # t - where to search; s - substring to find
  for i in range(len(t)):
    if t[i] == s[0]:
      for j in range(len(s)):
        if j == len(s)-1 and t[i] == s[j]:
          return True
        elif t[i] != s[j]:
          break;
        i += 1
  return False

def string_rotation(s1, s2):
  if len(s1) == len(s2):
    s1 *= 2
    return is_substring(s1, s2)
  return False

if string_rotation(sys.argv[1], sys.argv[2]):
  print("second string is a rotation of first")
