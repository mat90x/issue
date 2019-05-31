#!/usr/bin/awk -f
# Check for password and UID integrity.
{
    split($0, field, ":")
    usr = field[1]
    pasw = field[2]
    usr_id = field[3]
    usr_inf = field[5]

    if(pasw == "") {
        if(usr_inf == "") {
            print usr " has no password."
        }
        else {
            print usr " (" usr_inf ") has no password."
        }
    }

    if(usr_id in uid) {
        print usr " has the same UID as " uid[usr_id] " : UID = " usr_id
    }
    else {
        uid[usr_id] = usr
    }
}
