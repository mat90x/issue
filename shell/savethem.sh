#!/bin/bash
# From Sobell's...
# Write a program which will print the files' content from current directory
# into file 'savethem'. Avoid tries to print directories, the present script
# and 'savethem' file.

exec > savethem # bind stdout with required file.

script_name=$(basename $0)
for f in *; do
    if [[ $f == "$script_name" || $f == "savethem" || -d "$f" ]]; then
        continue;
    fi

    echo "* $f:"
    cat $f
    echo ""
done
