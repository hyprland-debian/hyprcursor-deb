#!/usr/bin/env sh

set -eux

export VER="0.1.9"

mkdir /build
cd /build

wget https://github.com/hyprwm/hyprcursor/archive/refs/tags/v$VER.tar.gz -O hyprcursor-$VER.tar.gz
tar -xzmf hyprcursor-$VER.tar.gz
cd /build/hyprcursor-$VER

cp -r /shared/debian /build/hyprcursor-$VER/debian
sed -i "s/VERSION_TEMPLATE/$VER/g" /build/hyprcursor-$VER/debian/changelog
sed -i "s/VERSION_TEMPLATE/$VER/g" /build/hyprcursor-$VER/debian/control
dpkg-buildpackage -us -uc

cd /build
ls -l

cp hyprcursor_$VER\_amd64.deb /shared

cd /shared
dpkg-deb -c hyprcursor_$VER\_amd64.deb
dpkg -I hyprcursor_$VER\_amd64.deb
