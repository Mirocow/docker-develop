ARG DOCKER_GEN_VERSION

FROM jwilder/docker-gen:$DOCKER_GEN_VERSION

RUN apk update && apk upgrade && apk add --no-cache --allow-untrusted \
	nano \
	supervisor \
	curl \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/* \
	&& rm -rvf /var/lib/apt/lists/* \
	rm -vf /etc/ssh/ssh_host_*

ADD supervisord.conf /etc/supervisor/supervisord.conf

ENTRYPOINT ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
