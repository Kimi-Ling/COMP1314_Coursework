#!/bin/bash

# Grep the week in seperate two weeks
# Week 1
grep -E '01-12-2025|02-12-2025|03-12-2025|04-12-2025|05-12-2025' gold_price.txt > gold_week1.txt

# Clean data for reading and plotting
awk '{
    datetime = $1 " " $2;
    if (match($0, /Gold:[ ]*([0-9.]+)/, arr)) {
        print datetime, arr[1];
    }
}' gold_week1.txt > gold_week1_clean.txt

# Plot week 1
gnuplot <<EOF
set terminal png size 800, 600 font 'Arial'
set output 'week1_goldprice.png'
set xlabel 'Date & Time'
set xdata time
set timefmt "%d-%m-%Y %H:%M:%S"
set format x "%d-%m\n%H:%M"
set ylabel 'Price (USD)'
set title 'Gold Prices - Week 1'
set grid
plot "gold_week1_clean.txt" using (stringcolumn(1) . " " . stringcolumn(2)):3 with lines title "Gold"
EOF
