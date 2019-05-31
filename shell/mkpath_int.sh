#!/bin/bash
# From Sobell's...
# Write a program that, given a pathname, creates all components in that
# pathname as directories. Make it interactive and don't use recursions. For
# example, the command 'makepath a/b/c/d' should create directories 'a', 'a/b',
# 'a/b/c/d'.

mkpath() {
    if [[ ${#1} -eq 0 || -d "$1" ]]; then # pass if isn't specified or exists.
            return 0
    fi  

    if [[ "${1%/*}" == "$1" ]]; then # create non-nested directory.
        mkdir $1
        return $?
    fi  

    start_dir=$(pwd)
    while read -d"/" p; do
        mkdir "$p"
        cd "$p"
    done <<<"$1"

    cd "$start_dir"
    mkdir $1
    return $?
}

mkpath $1
