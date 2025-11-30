#!/bin/bash

# Get timestamp
TIMESTAMP=$(date '+%d-%m-%Y %H:%M:%S')

# fetch json from goldprice
JSON=$(curl -s -H "User-Agent: Mozilla/5.0" "https://data-asg.goldprice.org/dbXRates/USD")

# parse using jq
GOLD=$(echo "$JSON" | jq -r '.items[0].xauPrice')
SILVER=$(echo "$JSON" | jq -r '.items[0].xagPrice')

# append to file
echo "$TIMESTAMP | Gold: $GOLD | Silver: $SILVER" >> gold_price.txt

# print confirmation to terminal
echo "Saved: $TIMESTAMP | Gold: $GOLD | Silver: $SILVER"

