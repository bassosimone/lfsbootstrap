#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack sed
tar -xf $LFS/usr/src/sed-4.9.tar.xz

# enter into sources dir
cd sed-4.9

# configure sed
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build sed
make

# install sed
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf sed-4.9
