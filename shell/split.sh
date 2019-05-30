#!/bin/bash
# From Sobell's...
# Write a progam that takes a colon-separated list of items and outputs the
# items, one per line, to standard output without the colons. Generalize it so
# that the character separating the list items is given as an argument to the
# program. If this argument is absent, the separator should default to colon.

split() {
    IFS=${2:-:}
    read -a list <<< "$1"
    for e in ${list[@]}; do
        echo "$e"
    done
}

split $1 $2
