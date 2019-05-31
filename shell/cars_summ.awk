#!/usr/bin/awk -f
# From Sobell's...
# Print summary aggregates.
BEGIN {
    total_years = 0
    total_cost = 0
    total_cost_new = 0
    total_count_new = 0
}
{
    total_years += $3
    total_cost += $5
}
$3 > 2000 {
    total_cost_new += $5
    total_count_new++
}
END {
    printf "avg age of cars is %4.1f years\n", 2006 - (total_years / NR)
    printf "avg cost of cars is $%7.2f\n", total_cost / NR
    printf "avg cost of new cars is $%7.2f\n", total_cost_new / total_count_new
}
