#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack gcc
tar -xf $LFS/usr/src/gcc-13.2.0.tar.xz

# enter into sources dir
cd gcc-13.2.0

# create and enter into build dir
mkdir build
cd build

# configure libstdc++
../libstdc++-v3/configure \
	--host=$LFS_TGT \
	--build=$(../config.guess) \
	--prefix=/usr \
	--disable-multilib \
	--disable-nls \
	--disable-libstdcxx-pch \
	--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/13.2.0

# build libstdc++
make

# install libstdc++
make DESTDIR=$LFS install

# remove .la files
rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la

# remove sources
cd $TOPDIR
rm -rf gcc-13.2.0
