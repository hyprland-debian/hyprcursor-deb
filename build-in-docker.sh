#!/usr/bin/env sh

set -eux

if [[ ! -v BUILD_VERSION ]]; then
    echo "BUILD_VERSION is not set"
    exit 1
fi

mkdir /build
cd /build

wget https://github.com/hyprwm/hyprcursor/archive/refs/tags/v$BUILD_VERSION.tar.gz -O hyprcursor-$BUILD_VERSION.tar.gz
tar -xzmf hyprcursor-$BUILD_VERSION.tar.gz
cd /build/hyprcursor-$BUILD_VERSION

cp -r /shared/debian /build/hyprcursor-$BUILD_VERSION/debian
sed -i "s/VERSION_TEMPLATE/$BUILD_VERSION/g" /build/hyprcursor-$BUILD_VERSION/debian/changelog
sed -i "s/VERSION_TEMPLATE/$BUILD_VERSION/g" /build/hyprcursor-$BUILD_VERSION/debian/control
dpkg-buildpackage -us -uc

cd /build
ls -l

cp hyprcursor_$BUILD_VERSION\_amd64.deb /shared

cd /shared
dpkg-deb -c hyprcursor_$BUILD_VERSION\_amd64.deb
dpkg -I hyprcursor_$BUILD_VERSION\_amd64.deb
