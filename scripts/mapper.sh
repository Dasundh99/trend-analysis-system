#!/bin/bash
while IFS=',' read -r product score timestamp
do
  if [[ "$score" =~ ^[0-9]+$ ]] && [[ "$timestamp" =~ ^[0-9]+$ ]]; then
    year=$(date -d @"$timestamp" +%Y 2>/dev/null)
    if [ ! -z "$year" ]; then
      echo -e "${product}_${year}\t${score}"
    fi
  fi
done
