#!/bin/bash
# From Sobell's...
# Implement the 'basename' utility, which writes the last component of its
# pathname argument to standard output, as a bash function. Also, if one pases
# the second argument in the form 'basename path suffix', basename removes the
# 'suffix' and the 'prefix' from path.
# $ basename a/b/c/d
# d
# $ basename src/shellfiles/prog.bash .bash
# prog
# $ basename src/shellfiles/prog.bash .c
# prog.bash

basename () {
    base=$(echo $1 | sed -r 's/.*\/(.*)$/\1/')
    if [ -z "$base" -a -z "$2" ]; then
        echo $base
    else
        suffix=$(echo $base | sed -r "s/^(.*)$2$/\1/")
        if [ -n "$suffix" ]; then
            echo $suffix
        fi
    fi
}

basename $1 $2
