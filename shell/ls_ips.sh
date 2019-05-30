#!/bin/bash
# Write program which lists the N most used IP addresses whithin S seconds.
# Records' format is the following:
# [dateime]\t[ip address]\t[message]

# Usage:
# n_most_used_ips_timeframe.sh filename [N] [S]

if [ -z "$2" ]; then
    N=20
else
    N=$2
fi
if [ -z "$3" ]; then
    S=86400
else 
    S=$3
fi

# Count all IP adresses and filter them by date and time.
declare -A ips_count
while IFS=$'\t' read dt ip remainder; do
    dt_ts=$(date -d "$dt" +%s)

    if [ $dt_ts -le $S ]; then
        ((++ips_count["$ip"]))
    fi
done < $1

if ((${#ips_count[@]} == 0)); then
    echo "no ips were found"
    exit 0
fi

# List number of counted and filtered IP addresses in decreasing order.
for ((i=0; i < $2 && ${#ips_count[@]} > 0; ++i)); do

    maxcount=0
    maxip=""

    for k in "${!ips_count[@]}"; do
        if [ ${ips_count[$k]} -gt $maxcount ]; then
            maxcount=${ips_count[$k]}
            maxip=$k
        fi
    done

    unset ips_count[$maxip]
    echo "$maxip $maxcount"
done
