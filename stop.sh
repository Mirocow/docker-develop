#!/bin/bash

echo "STOP PROXY"

docker-compose -f docker-compose.yml down

exit 0