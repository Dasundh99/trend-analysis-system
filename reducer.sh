#!/bin/bash
current_key=""
sum=0
count=0

while read line; do
  key=$(echo "$line" | cut -f1)
  value=$(echo "$line" | cut -f2)
  
  if [ "$current_key" == "$key" ]; then
    sum=$((sum + value))
    count=$((count + 1))
  else
    if [ "$current_key" != "" ]; then
      avg=$(echo "scale=2; $sum / $count" | bc)
      echo -e "$current_key\t$avg"
    fi
    current_key=$key
    sum=$value
    count=1
  fi
done

# Output the last key
if [ "$current_key" != "" ]; then
  avg=$(echo "scale=2; $sum / $count" | bc)
  echo -e "$current_key\t$avg"
fi
