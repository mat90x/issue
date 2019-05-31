#!/usr/bin/awk -f
# From Sobell's
# Count cars models by custom field.
# ./cars_cnt_fld.awk [-v field=...]
{
    if (!field) field = 1
    split($0, line, "\t")
    arr[line[field]]++
}
END {
    for (car in arr)
        print car, arr[car]
}
