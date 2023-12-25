#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack gcc
tar -xf $LFS/usr/src/gcc-13.2.0.tar.xz

# enter into sources dir
cd gcc-13.2.0

# unpack additional gcc dependencies
tar -xf $LFS/usr/src/mpfr-4.2.0.tar.xz
mv -v mpfr-4.2.0 mpfr
tar -xf $LFS/usr/src/gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf $LFS/usr/src/mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# make sure we're not using lib64
case $(uname -m) in
x86_64)
	sed -e '/m64=/s/lib64/lib/' \
		-i.orig gcc/config/i386/t-linux64
	;;
esac

# build libgcc and libstdc++ with threading support
sed '/thread_header =/s/@.*@/gthr-posix.h/' \
	-i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

# create and enter into build dir
mkdir build
cd build

# configure gcc
../configure \
	--build=$(../config.guess) \
	--host=$LFS_TGT \
	--target=$LFS_TGT \
	LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
	--prefix=/usr \
	--with-build-sysroot=$LFS \
	--enable-default-pie \
	--enable-default-ssp \
	--disable-nls \
	--disable-multilib \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libsanitizer \
	--disable-libssp \
	--disable-libvtv \
	--enable-languages=c,c++

# build gcc
make

# install gcc
make DESTDIR=$LFS install

# create the cc alias
ln -sfv gcc $LFS/usr/bin/cc

# remove sources
cd $TOPDIR
rm -rf gcc-13.2.0
