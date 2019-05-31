#!/usr/bin/awk -f
# From Sobell's...
# Write a program that displays all cars priced at more than $5,000.
# ./cars_price_limit.awk [-v p=...]
BEGIN {
    if(!p) p = 5000
}
$5 >= p {
    print $0
}
