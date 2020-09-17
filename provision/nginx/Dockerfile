ARG NGINX_VERSION

FROM nginx:$NGINX_VERSION

EXPOSE 22 80

RUN apk update && apk upgrade && apk add --no-cache --allow-untrusted \
	git \
	nano \
	supervisor \
	openssh-server \
	openssh \
	openssl \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/* \
	&& rm -rvf /var/lib/apt/lists/* \
	rm -vf /etc/ssh/ssh_host_*

RUN addgroup -g 1000 -S publisher && \ 
	adduser -s /bin/sh -u 1000 -g '' -h /home/publisher -D -S publisher -G publisher publisher && \
	echo "publisher:publisher" | chpasswd && \
	mkdir -p /app /run/sshd /home/publisher/.ssh && \
	chown publisher:publisher /app /home/publisher/.ssh

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD entrypoint.sh /entrypoint.sh
ADD sshd-config.sh /sshd.sh

RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]