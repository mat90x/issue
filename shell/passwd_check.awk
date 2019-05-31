#!/usr/bin/awk -f
# Check for password and uid integrity.
BEGIN {
    uid[void] = ""
}
{
    dup = 0
    split($0, field, ":")

    if(field[2] == "") {
        if(field[5] == "") {
            print field[1] " has no password."
        }
        else {
            print field[1] " (" field[5] ") has no password."
        }
    }

    for(name in uid) {
        if(uid[name] == field[3]) {
            print field[1] " has the same UID as " name " : UID = " uid[name]
            dup = 1
        }
    }

    if(!dup) {
        uid[field[1]] = field[3]
    }
}
