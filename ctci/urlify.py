#!/usr/bin/python3
"""
CtCI 1.3. Write a method to replace all spaces in a string with '%20'. You may
assume that the string has sufficient space at the end to hold the additional
characters, and that you are given the "true" length of the string.
"""
import sys

def urlify(s):
  res = ""
  for c in s:
    if c == " ":
      res += "%20"
    else:
      res += c
  return res

print(urlify(sys.argv[1]))
