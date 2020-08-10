#!/bin/bash

# set max wait time for container (in seconds)
MAX_WAIT=30

# print helpers
print_success() {
    echo "SUCCESS: $1"
}
print_error() {
    echo "ERROR: $1"
}

# check container status X amount of seconds
check_container() {
    local end=$((SECONDS + MAX_WAIT))
    while [ $SECONDS -lt $end ]; do
        sudo docker exec $1 echo 'Still alive!' &>/dev/null
        # container is up and running
        if [ $? -eq 0 ]; then
            return 0
        fi
        # container still not up, sleep until trying again
        sleep 1
    done
    return 1
}

# loop over each container and check if its up
for container_id in $(sudo docker-compose ps -q); do
    check_container $container_id
    if [ $? -eq 0 ]; then
        print_success "Container $container_id is up"
    else
        print_error "Container $container_id still not up after $MAX_WAIT seconds"
        exit 1
    fi
done

print_success "All containers running!"