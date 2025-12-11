#!/bin/bash

# Get the max and min price from each day
awk '{

	date = $1
	price = $3

	if (!(date in max) || price >  max[date]) max[date] = price
	if (!(date in min) || price < min[date]) min[date] = price

}

END{
	print "date max_price min_price"
	for (d in max) print d, max[d], min[d]
}' gold_week1_clean.txt | sort > max_min_week1_daily.txt

