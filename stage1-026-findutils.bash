#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack findutils
tar -xf $LFS/usr/src/findutils-4.9.0.tar.xz

# enter into sources dir
cd findutils-4.9.0

# configure findutils
./configure --prefix=/usr \
	--localstatedir=/var/lib/locate \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build findutils
make findutils_COMPILE=$(pwd)/build/src/findutils

# install findutils
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf findutils-4.9.0
