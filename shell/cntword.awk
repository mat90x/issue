#!/usr/bin/awk -f
# From Sobell's...
# Determine how many lines in /usr/share/dict/words contain the string 'abul'.
# ./cntword.awk [-v str=...] ...
BEGIN {
    if(!str) str = "abul"
}
$0 ~ str {
    ++count
}
END {
    print "found " count " lines of '" str "' in '" FILENAME "'"
}
