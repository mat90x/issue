#!/usr/bin/python3
"""Find longest subsequnces of repeating characters in string"""

for s in [
    'aabbcddaaappbbbcc',
    'abc',
    'abbccc'
    ]:
    digest = {}
    cnt = 1;
    for i in range(1, len(s)):
        if s[i] != s[i-1]:
            if (
                s[i-1] in digest and cnt > digest[s[i-1]]
                or s[i-1] not in digest
                ):
                digest[s[i-1]] = cnt
            cnt = 1
        else:
            cnt = cnt + 1
    
    if s[-1] in digest and cnt > digest[s[-1]] or s[-1] not in digest:
        digest[s[-1]] = cnt

    print('string "' + s + '" has following longest subsequences:\n'
        + ('\n'.join('%s = %d' % (k, v) for (k,v) in sorted(digest.items())))
        )
    # print('string "' + s + '" has following longest subsequences:\n'
    #     + ('\n'.join('%s = %d' %
    #         (k, digest[k]) for k in sorted(digest.keys()))
    #         )
    #     )
