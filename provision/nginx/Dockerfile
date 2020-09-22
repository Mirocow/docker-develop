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

# Download sources
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx.tar.gz && \
	wget "https://github.com/wandenberg/nginx-push-stream-module/archive/master.tar.gz" -O push.tar.gz
	
# Add nginx-push-stream-module
RUN apk add --no-cache --virtual .build-deps \
	gcc \
	libc-dev \
	make \
	openssl-dev \
	pcre-dev \
	zlib-dev \
	linux-headers \
	curl \
	gnupg \
	libxslt-dev \
	gd-dev \
	geoip-dev
	
# Reuse same cli arguments as the nginx:alpine image used to build
RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
	tar -zxC /tmp -f nginx.tar.gz && \
	tar -xzvf "push.tar.gz" && \
	PUSHDIR="$(pwd)/nginx-push-stream-module-master" && \
	cd /tmp/nginx-$NGINX_VERSION && \
	./configure --with-compat $CONFARGS --add-dynamic-module=$PUSHDIR && \
	make && make install

# Extract the dynamic module NCHAN from the builder image
RUN cp /usr/local/nginx/modules/ngx_http_push_stream_module.so /usr/lib/nginx/modules/ngx_http_push_stream_module.so

ADD etc/nginx.conf /etc/nginx/nginx.conf
ADD etc/fastcgi_params /etc/nginx/fastcgi_params

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD entrypoint.sh /entrypoint.sh
ADD sshd-config.sh /sshd.sh

RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]