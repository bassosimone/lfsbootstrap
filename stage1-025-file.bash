#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack file
tar -xf $LFS/usr/src/file-5.45.tar.gz

# enter into sources dir
cd file-5.45

# we need to use on the host the same version we're cross compiling
mkdir build
pushd build
../configure --disable-bzlib \
	--disable-libseccomp \
	--disable-xzlib \
	--disable-zlib
make
popd

# configure file
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

# build file
make FILE_COMPILE=$(pwd)/build/src/file

# install file
make DESTDIR=$LFS install

# remove .la file
rm -v $LFS/usr/lib/libmagic.la

# remove sources
cd $TOPDIR
rm -rf file-5.45
