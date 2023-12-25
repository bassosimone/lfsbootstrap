#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack xz
tar -xf $LFS/usr/src/xz-5.4.4.tar.xz

# enter into sources dir
cd xz-5.4.4

# configure xz
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--disable-static \
	--docdir=/usr/share/doc/xz-5.4.4

# build xz
make

# install xz
make DESTDIR=$LFS install

# remove .la file
rm -v $LFS/usr/lib/liblzma.la

# remove sources
cd $TOPDIR
rm -rf xz-5.4.4
