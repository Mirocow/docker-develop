FROM alpine

RUN set -xe \
    && apk add --no-cache dnsmasq \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && rm -rvf /var/lib/apt/lists/* \
    rm -vf /etc/ssh/ssh_host_*

VOLUME /etc/dnsmasq

### allow ports
EXPOSE 53/tcp 53/udp 67/udp 69/udp

ENTRYPOINT ["/usr/sbin/dnsmasq", "--no-daemon", "-k", "-C", "/etc/dnsmasq.conf"]