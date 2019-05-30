#!/bin/bash
# From Sobell's...
# The 'dirname' utility treats its arguments as a pathname and writes to
# standard output the path prefix - that is, everything up to but not including
# the last component. If one give dirname a simple filename (no / characters)
# as an argument, dirname writes a . to standard output.
# $ dirname a/b/c/d
# a/b/c
# $dirname simple
# .

dirname () {
    prefix=$(echo $1 | sed -r 's/^(.*)\/.*$/\1/')
    if [ "$prefix" = "" -o "$prefix" = "$1" ]; then
        echo "."
    else
        echo $prefix
    fi
}

dirname $1
