#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack patch
tar -xf $LFS/usr/src/patch-2.7.6.tar.xz

# enter into sources dir
cd patch-2.7.6

# configure patch
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build patch
make

# install patch
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf patch-2.7.6
