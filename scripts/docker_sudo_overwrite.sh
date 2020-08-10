#! /bin/sh 
# This basically is a workaround to add sudo to the docker command, because aliases don't seem to work 
# To be honest, this is a horrible workaround that depends on the order in $PATH
# This file needs to be place in /usr/local/bin with execute permissions
if [[ -f /usr/bin/docker-compose ]]; then
    sudo /usr/bin/docker-compose $@
elif [[ -f /usr/local/bin/docker-compose ]]; then
    sudo /usr/local/bin/docker-compose $@
else
    exit
fi