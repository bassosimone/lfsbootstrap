#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack grep
tar -xf $LFS/usr/src/grep-3.11.tar.xz

# enter into sources dir
cd grep-3.11

# configure grep
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(./build-aux/config.guess)

# build grep
make

# install grep
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf grep-3.11
