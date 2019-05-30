#!/bin/bash
# From Sobell's...
# Write a short script that tells whether the permissions for two files, whose
# names are given as arguments to the script, are identical. If the permission
# for the two files are identical, output the common permission field.
# Otherwise, output each filename followed by its permission field.

perms=($(stat -c "%a %n" "$1" "$2" | cut -f1 -d' '))
if [ ${perms[0]} -eq ${perms[1]} ]; then
    echo "common permissions is "$((${perms[0]} & ${perms[1]}))
else    
    echo "permissions are ${perms[0]} and ${perms[1]}"
fi
