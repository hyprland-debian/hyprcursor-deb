#!/usr/bin/env bash

VER=0.1.9

wget https://github.com/hyprwm/hyprcursor/archive/refs/tags/v$VER.tar.gz -O hyprcursor-$VER.tar.gz
tar -xzmf hyprcursor-$VER.tar.gz
cd hyprcursor-$VER

mkdir debian
 
cat > debian/changelog <<EOF
hyprcursor ($VER) unstable; urgency=low

  * Release

 -- John Doe <john@doe.org>  Wed, 22 May 2024 17:54:24 +0000
EOF

cat > debian/rules <<EOF
#!/usr/bin/make -f
export DH_VERBOSE = 1

%:
	dh \$@ --buildsystem=cmake

override_dh_auto_test:
EOF
chmod +x debian/rules

cat > debian/control <<EOF
Source: hyprcursor
Section: utils
Priority: extra
Maintainer: John Doe <john@doe.org>
Build-Depends: debhelper (>= 0.0.0), cmake (>= 3.27.0), pkg-config (>= 0.0.0), libhyprlang-dev (>= 0.4.2), libzip-dev (>= 0.0.0), librsvg2-dev (>= 0.0.0), libtomlplusplus-dev (>= 0.0.0)
Standards-Version: $VER

Package: hyprcursor
Section: utils
Priority: extra
Architecture: amd64
Depends: \${shlibs:Depends}
Description: The hyprland cursor format, library and utilities.
EOF

echo 10 > debian/compat

dpkg-buildpackage -S -nc

cd ..

pbuilder build hyprcursor_$VER.dsc

dpkg -I /var/cache/pbuilder/result/hyprcursor_$VER\_amd64.deb
