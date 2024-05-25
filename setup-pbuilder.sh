#!/usr/bin/env bash

echo "deb http://deb.debian.org/debian unstable main" > /etc/apt/sources.list
rm -f /etc/apt/sources.list.d/debian.sources

apt update
apt -y upgrade
apt install -y pbuilder

if [ ! -f /var/cache/pbuilder/base.tgz ]; then
    pbuilder create --distribution sid
fi
