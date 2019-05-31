#!/usr/bin/awk -f
# Print each word with the number of its occurences.
{
    for(i=1; i<=NF; ++i)
        ++arr[$i]
}
END {
    for(k in arr)
        print k, arr[k]
}
