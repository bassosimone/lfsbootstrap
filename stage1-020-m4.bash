#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack m4
tar -xf $LFS/usr/src/m4-1.4.19.tar.xz

# enter into sources dir
cd m4-1.4.19

# configure m4
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build m4
make

# install m4
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf m4-1.4.19
