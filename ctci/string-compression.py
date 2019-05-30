#!/usr/bin/python3
"""
CtCI 1.6. Implement a method to perform basic string compression using the
counts of repeated characters. For example, the string 'aabccccaaa' would
become 'a2b1c5a3'. If the "compressed" string would not become smaller the
original string, your method should return the original string. You can assume
the string has only upperca and lowercase letters (a-z).
"""
import sys

def string_compression(s):
  compressed = ""
  char_count = 1
  for i, k in enumerate(s[0:-1]):
    if s[i] != s[i+1]:
      compressed += s[i] + str(char_count)
      char_count = 1
    else:
      char_count += 1
  compressed += s[-1] + str(char_count)

  return s if len(compressed) > len(s) else compressed

print(string_compression(sys.argv[1]))
