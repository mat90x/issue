#!/bin/bash
# From Sobell's...
# Copies stdin to stdout if no argument given. Prints 1st file, if 2nd isn't
# set. Copies 1st file to 2nd, if both files are set.

cpcat() {
    case $# in
        0)
        exec 3<&0 4<&1 # duplicate stdin to file 3 and stdout to file 4
        ;;
        1)
        exec 3<$1 4<&1 # open 1st file for stdin, duplicate stdout to 4
        ;;
        2)
        exec 3<$1 4>$2 # open 1st file for stdout and 2nd file for stdin
        ;;
        *)
        echo "Usage: cpcat [source [dest]]"
        return 1
        ;;
    esac

    cat <&3 >&4 # catenate stdin of file 3 and stdout with file 4
    exec 3<&- 4<&- # close files 3 and 4
}

cpcat $@
