FROM alpine

RUN set -xe \
    && apk add --no-cache dnsmasq

VOLUME /etc/dnsmasq

### allow ports
EXPOSE 53/tcp 53/udp 67/udp 69/udp

ENTRYPOINT ["/usr/sbin/dnsmasq", "--no-daemon", "-k", "-C", "/etc/dnsmasq.conf"]