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

echo "START PROXY ON IP ${NETWORK_PROXY_IP}"

# 2. Create docker network
docker network create --driver=bridge --subnet=${NETWORK_SUBNET} ${NETWORK}

# 5. Update local images
docker-compose pull

# 6. Add any special configuration if it's set in .env file

# Check if user set to use Special Conf Files
if [ ! -z ${USE_NGINX_CONF_FILES+X} ] && [ "$USE_NGINX_CONF_FILES" = true ]; then

    # Create the conf folder if it does not exists
    mkdir -p $CONFIG_FILES_PATH/nginx/conf.d
		
		cp -R ./provision/nginx/htpasswd $CONFIG_FILES_PATH/nginx/htpasswd

    # Copy the special configurations to the nginx conf folder
    cp -R ./provision/nginx/conf.d/* $CONFIG_FILES_PATH/nginx/conf.d

    # Check if there was an error and try with sudo
    if [ $? -ne 0 ]; then
        sudo cp -R ./provision/nginx/conf.d/* $CONFIG_FILES_PATH/nginx/conf.d
    fi

    # If there was any errors inform the user
    if [ $? -ne 0 ]; then
        echo
        echo "#######################################################"
        echo
        echo "There was an error trying to copy the nginx conf files."
        echo "The webproxy will still work, your custom configuration"
        echo "will not be loaded."
        echo 
        echo "#######################################################"
    fi

fi 

# Create the conf folder if it does not exists
mkdir -p $CONFIG_FILES_PATH/dnsmasq/dnsmasq.d

# Copy the special configurations to the nginx conf folder
cp -R ./provision/dnsmasq/dnsmasq.d/* $CONFIG_FILES_PATH/dnsmasq/dnsmasq.d

# Copy the special configurations to the dnsmasq conf file
cp ./provision/dnsmasq/dnsmasq.conf $CONFIG_FILES_PATH/dnsmasq/dnsmasq.conf

# 7. Start proxy

if [ ! -z ${VERBOSE} ] && [ "$VERBOSE" = true ]; then
  docker-compose --verbose up -d --build
else
  docker-compose up -d --build
fi

exit 0
