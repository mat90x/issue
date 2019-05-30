#!/usr/bin/python3
""" To find if two words are anagrams, map each letter to prime number, then,
multiply them. Since the results are products of primes, two words will be
anagrams if their resulst are equal.

Courtesy of:
https://twitter.com/fermatslibrary/status/958700402647674880    """

letter_to_prime = {
    'A': 2,  'B': 3,  'C': 5,  'D': 7,  'E': 11, 'F': 13, 'G': 17, 'H': 19,
    'I': 23, 'J': 29, 'K': 31, 'L': 37, 'M': 41, 'N': 43, 'O': 47, 'P': 53,
    'Q': 59, 'R': 61, 'S': 67, 'T': 71, 'U': 73, 'V': 79, 'W': 83, 'X': 89,
    'Y': 97, 'Z': 101
}


def mult(word):
    product = 1
    for l in word:
        if l == ' ':
            continue
        product = product * letter_to_prime[l]
    return product


for c in [
    ['LOST', 'LAST'],
    ['GET', 'GIT'],
    ['FIZZ', 'BUZZ'],
    ['SIZZLE', 'FIZZLE'],
    ['FUNERAL', 'TRUE FUN'],
    ['CUSTOMERS', 'STORE SCUM'],
    ['YEAR', 'YARE'],
    ]:
    print(c[0] + ' and ' + c[1]
        + (' are' if mult(c[0]) == mult(c[1]) else " aren't")
        + ' anagrams'
        )