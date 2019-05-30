#!/usr/bin/python3
"""
CtCI 1.5. There are three types of edits that can be performed on strings:
insert a character, remove a character, or replace a character. Given two
strings, write a function to check if they are one edit (or zero edits) away.
"""
import sys

def one_way(s1, s2):
  if s1 == s2:
    return True

  if abs(len(s1) - len(s2)) > 1:
    return False

  if len(s1) < len(s2):
    s1, s2 = s2, s1

  for i, k in enumerate(s1):
    if i >= len(s2):          # insert at the end
      return s1 == s2 + s1[i]
    elif s1[i] != s2[i] and (
      s1 == s2[0:i] + s2[i+1:len(s2)]                # remove
        or s1 == s2[0:i] + s1[i] + s2[i:len(s2)]     # insert
          or s1 == s2[0:i] + s1[i] + s2[i+1:len(s2)] # replace
    ):
      return True

  return False

if one_way(sys.argv[1], sys.argv[2]):
  print("strings are zero or one edit away")
