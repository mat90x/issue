#!/bin/bash
# From Sobell's...
# Identifies hard links to a file

msg() {
    echo "$1" 1>&2
}

usage() {
    msg "Usage: links.sh file [directory]"
    exit 1
}

if [ $# -eq 0 -o $# -gt 2 ]; then
    usage
elif [ -d "$1" ]; then
    msg "First argument cannot be a directory"
    usage
else
    file="$1"
fi

if [ $# -eq 1 ]; then
    directory="."
elif [ -d "$2" ]; then
    directory="$2"
else
    msg "Optional second argument must be a directory"
    usage
fi

if [ ! -f "$file" ]; then
    msg "'$file' not found or special file"
    exit 1
fi

# check links count on file
set -- $(ls -l "$file")
count=$2
if [ "$count" -eq 1 ]; then
         "no other hard links to '$file'"
    exit 0
fi

# retrieve inode of the given file
set $(ls -i $file)
inode=$1

# find and print the files with the same inode number
msg "using find to search for links..."
find "$directory" -xdev -inum $inode -print
