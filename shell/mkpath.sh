#!/bin/bash
# From Sobell's...
# Write a program that, given a pathname, creates all components in that
# pathname as directories, For example, the command 'makepath a/b/c/d' should
# create directories 'a', 'a/b', 'a/b/c/d'.

mkpath() {
    if [[ ${#1} -eq 0 || -d "$1" ]]; then
        return 0
    fi

    if [[ "${1%/*}" = "$1" ]]; then
        # Create non-nested directory.
        mkdir $1
        return $?
    fi

    mkpath ${1%/*} || return 1 # continiously creating directories.

    mkdir $1
    return $?
}

mkpath $1
