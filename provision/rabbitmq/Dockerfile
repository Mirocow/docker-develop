FROM rabbitmq:3.8.0-rc.1-alpine

RUN apk update && apk upgrade && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && rm -rvf /var/lib/apt/lists/* \
    rm -vf /etc/ssh/ssh_host_*	

RUN echo '[rabbitmq_federation_management,rabbitmq_management,rabbitmq_mqtt,rabbitmq_stomp].' > /etc/rabbitmq/enabled_plugins

VOLUME /var/lib/rabbitmq