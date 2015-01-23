#!/bin/bash

: ${IRC_CHANNEL:='test'}
: ${IRC_NICK:='from_fluentd'}

sed -i.old "s/%IRC_CHANNEL%/${IRC_CHANNEL}/"   /etc/fluentd.conf
sed -i.old "s/%IRC_NICK%/${IRC_NICK}/"         /etc/fluentd.conf
sed -i.old "s/%IRC_PASSWORD%/${IRC_PASSWORD}/" /etc/fluentd.conf

cd /app
/usr/local/bin/foreman start
