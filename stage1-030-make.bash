#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack make
tar -xf $LFS/usr/src/make-4.4.1.tar.gz

# enter into sources dir
cd make-4.4.1

# configure make
./configure --prefix=/usr \
	--without-guile \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build make
make

# install make
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf make-4.4.1
