#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack ncurses
tar -xf $LFS/usr/src/ncurses-6.4.tar.gz

# enter into sources dir
cd ncurses-6.4

# make sure we end up using gawk
sed -i s/mawk// configure

# build the tic program on the build host
mkdir build
pushd build
../configure
make -C include
make -C progs tic
popd

# configure ncurses
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(./config.guess) \
	--mandir=/usr/share/man \
	--with-manpage-format=normal \
	--with-shared \
	--without-normal \
	--with-cxx-shared \
	--without-debug \
	--without-ada \
	--disable-stripping \
	--enable-widec

# build ncurses
make

# install ncurses
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" >$LFS/usr/lib/libncurses.so

# remove sources
cd $TOPDIR
rm -rf ncurses-6.4
