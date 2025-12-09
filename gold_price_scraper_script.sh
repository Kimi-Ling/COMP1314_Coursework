#!/bin/bash

# Get timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# fetch json from goldprice
JSON=$(curl -s -H "User-Agent: Mozilla/5.0" "https://data-asg.goldprice.org/dbXRates/USD")

# parse using jq
GOLD=$(echo "$JSON" | jq -r '.items[0].xauPrice')
SILVER=$(echo "$JSON" | jq -r '.items[0].xagPrice')

# append to file
echo "$TIMESTAMP | Gold: $GOLD | Silver: $SILVER" >> gold_price.txt

# Insert into MySQL
/opt/lampp/bin/mysql -u root -e "USE gold_price_tracker; INSERT INTO gold_prices (timestamp, gold_price, silver_price) VALUES ('$TIMESTAMP', $GOLD, $SILVER);"

# print confirmation to terminal
echo "Saved: $TIMESTAMP | Gold: $GOLD | Silver: $SILVER"

