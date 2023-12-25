#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack gawk
tar -xf $LFS/usr/src/gawk-5.2.2.tar.xz

# enter into sources dir
cd gawk-5.2.2

# don't install extras
sed -i 's/extras//' Makefile.in

# configure gawk
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)

# build gawk
make

# install gawk
make DESTDIR=$LFS install

# remove sources
cd $TOPDIR
rm -rf gawk-5.2.2
