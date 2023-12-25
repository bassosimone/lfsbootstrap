#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack binutils
tar -xf $LFS/usr/src/binutils-2.41.tar.xz

# enter into sources dir
cd binutils-2.41

# create and enter into build dir
mkdir build
cd build

# configure binutils
../configure --prefix=$LFS/tools \
	--with-sysroot=$LFS \
	--target=$LFS_TGT \
	--disable-nls \
	--enable-gprofng=no \
	--disable-werror

# build binutils
make

# install binutils
make install

# remove sources
cd $TOPDIR
rm -rf binutils-2.41
