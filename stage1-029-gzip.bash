#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack gzip
tar -xf $LFS/usr/src/gzip-1.12.tar.xz

# enter into sources dir
cd gzip-1.12

# configure gzip
./configure --prefix=/usr --host=$LFS_TGT

# build gzip
make

# install gzip
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf gzip-1.12
