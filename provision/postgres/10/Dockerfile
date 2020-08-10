FROM postgres:10.0-alpine

RUN apk update && apk upgrade && rm -rf /var/cache/apk/*	

# Set Workdir
WORKDIR /app

COPY postgresql.conf.tpl /etc/postgresql/postgresql.conf

CMD ["-c", "config_file=/etc/postgresql/postgresql.conf"]