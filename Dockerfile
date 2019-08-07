FROM ubuntu:19.10

ARG TOOLCHAIN_FLAVOR=linux
ENV TOOLCHAIN_FLAVOR=$TOOLCHAIN_FLAVOR

RUN apt-get update && apt-get install -y \
    build-essential wget git libsodium-dev graphviz \
    valgrind check libssl-dev libusb-1.0-0-dev libudev-dev zlib1g-dev \
    libsdl2-dev libsdl2-image-dev


ENV TOOLCHAIN_SHORTVER=8-2018q4
ENV TOOLCHAIN_LONGVER=gcc-arm-none-eabi-8-2018-q4-major
ENV TOOLCHAIN_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/$TOOLCHAIN_SHORTVER/$TOOLCHAIN_LONGVER-$TOOLCHAIN_FLAVOR.tar.bz2
ENV TOOLCHAIN_HASH_linux=fb31fbdfe08406ece43eef5df623c0b2deb8b53e405e2c878300f7a1f303ee52
ENV TOOLCHAIN_HASH_src=bc228325dbbfaf643f2ee5d19e01d8b1873fcb9c31781b5e1355d40a68704ce7

RUN cd /opt && wget $TOOLCHAIN_URL

RUN cd /opt && echo "$TOOLCHAIN_HASH_linux $TOOLCHAIN_LONGVER-linux.tar.bz2\n$TOOLCHAIN_HASH_src $TOOLCHAIN_LONGVER-src.tar.bz2" | sha256sum -c --ignore-missing

RUN cd /opt && tar xfj $TOOLCHAIN_LONGVER-$TOOLCHAIN_FLAVOR.tar.bz2

ENV PATH=/opt/$TOOLCHAIN_LONGVER/bin:$PATH

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
