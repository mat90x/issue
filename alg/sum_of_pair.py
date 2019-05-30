#!/usr/bin/python3
""" Find if given sequnce has pair of numbers which in sum gives the desired
number """

def has_pair(seq, num):
    digest = {}
    for n in seq:
        if n not in digest:
            digest[n] = 1
            continue
        digest[n] = digest[n] + 1

    for n in digest:
        if n * 2 == num:
            if digest[n] == 1:
                continue
            else:
                return True
        elif (num - n) in digest:
            return True

    return False

num = 6
for seq in [
    [1, 3, 3, 4],
    [1, 2, 3, 4],
    [0, 2, 6],
    [1, 2, 3],
    [7, 2, -1],
    [],
    [num],
    [num, num, num]
    ]:
    print('Sequence ' + repr(seq)
        + (' has' if has_pair(seq, num) else " hasn't")
        + ' pair which in sum gives ' + str(num)
        )