#!/usr/bin/awk -f
# Print list of powers for 1..k for 'base'.
# ./powls.awk [-v base=...] [-v n=...]
BEGIN {
    if(!base) base = 2
    if(!n) n = 10
    for(i = 1; i <= n; ++i) {
        print base "^" i, base**i
    }
}
