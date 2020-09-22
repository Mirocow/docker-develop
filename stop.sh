#!/bin/bash

#
# This file should be used to prepare and run your WebProxy after set up your .env file
#

# 1. Check if .env file exists
if [ -e .env ]; then
    source .env
else 
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

echo "STOP PROXY"

docker-compose -f docker-compose.yml stop

rm -rf data

exit 0