#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack diffutils
tar -xf $LFS/usr/src/diffutils-3.10.tar.xz

# enter into sources dir
cd diffutils-3.10

# configure diffutils
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(./build-aux/config.guess)

# build diffutils
make

# install diffutils
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf diffutils-3.10
