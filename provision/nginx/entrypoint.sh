#!/usr/bin/env sh

. /sshd.sh

exec supervisord -n -c /etc/supervisor/supervisord.conf