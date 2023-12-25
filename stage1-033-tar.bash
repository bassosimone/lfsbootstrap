#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack tar
tar -xf $LFS/usr/src/tar-1.35.tar.xz

# enter into sources dir
cd tar-1.35

# configure tar
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build tar
make

# install tar
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf tar-1.35
