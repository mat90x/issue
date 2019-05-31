#!/usr/bin/awk -f
# From Sobell's
# Replace cars' prices with price assesments.
{
    if ($5 <= 5000) $5 = "inexpensive"
    else if (5000 < $5 && $5 < 10000) $5 = "please ask"
    else if (10000 <= $5) $5 = "expensive"

    printf "%-10s %-8s   %2d   %5d   %-12s\n", $1, $2, $3, $4, $5
}
