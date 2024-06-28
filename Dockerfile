FROM debian:unstable

RUN echo "deb http://deb.debian.org/debian unstable main" > /etc/apt/sources.list
RUN rm -f /etc/apt/sources.list.d/debian.sources

RUN apt update

RUN apt install -y curl git debhelper cmake pkg-config wget
RUN apt install -y libhyprlang-dev libzip-dev librsvg2-dev libtomlplusplus-dev


CMD ["/shared/build-in-docker.sh"]