#!/usr/bin/awk -f
# Print values from key=value pairs.
$0 != "" {
    for(i = 1; i <= NF; ++i) {
        print substr($i, index($i, "=") + 1)
    }
}