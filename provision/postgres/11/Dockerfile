FROM postgres:11.0-alpine

RUN apk update && apk upgrade && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && rm -rvf /var/lib/apt/lists/* \
    rm -vf /etc/ssh/ssh_host_*	

# Set Workdir
WORKDIR /app

COPY postgresql.conf.tpl /etc/postgresql/postgresql.conf

CMD ["-c", "config_file=/etc/postgresql/postgresql.conf"]