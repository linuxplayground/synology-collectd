#!/bin/sh

if [ -z "$@" ]; then
  exec /usr/sbin/collectd -C /etc/collectd/collectd.conf -f
else
  exec $@
fi

