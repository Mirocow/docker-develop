#!/bin/bash

#
# This scrip update the web proxy without downtime
#
#

# 1. Check if .env file exists
if [ -e .env ]; then
    source .env
else 
    echo 
    echo "Please set up your .env file before starting your enviornment."
    echo 
    exit 1
fi

# 2. Update your repo
git pull
git checkout master

# 3. Check if your env files has the same line numbers
if [ "$(wc -l .env | cut -f1 -d' ')" != "$(wc -l .env.sample | cut -f1 -d' ')" ]; then
    echo
    echo "The sample .env are different from the your current .env file."
    echo "Please update your .env file to continue."
    echo "It must has the same lines of the sample env file."
    echo
    echo "If you keep receiving this message please check the number of line of both files"
    echo
fi

# 4. Update containers without downtime
docker-compose up -d --no-deps --build nginx-web
docker-compose up -d --no-deps --build nginx-gen

exit 0
