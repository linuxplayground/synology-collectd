FROM alpine:latest
MAINTAINER David Latham <david.latham.nz@gmail.com>
RUN apk add --update \
    collectd \
    collectd-snmp \
  && rm -rf /var/cache/apk/*
COPY mibs/ /usr/share/snmp/mibs/
COPY config/ /etc/collectd/
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

