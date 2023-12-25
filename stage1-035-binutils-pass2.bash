#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack binutils
tar -xf $LFS/usr/src/binutils-2.41.tar.xz

# enter into sources dir
cd binutils-2.41

# workaround outdated libtool
sed '6009s/$add_dir//' -i ltmain.sh

# create and enter into build dir
mkdir build
cd build

# configure binutils
../configure \
	--prefix=/usr \
	--build=$(../config.guess) \
	--host=$LFS_TGT \
	--disable-nls \
	--enable-shared \
	--enable-gprofng=no \
	--disable-werror \
	--enable-64-bit-bfd

# build binutils
make

# install binutils
make DESTDIR=$LFS install

# remove .la and .a files
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

# remove sources
cd $TOPDIR
rm -rf binutils-2.41
