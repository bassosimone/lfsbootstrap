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

# create and enter into build dir
mkdir build
cd build

# configure gcc
../configure \
	--target=$LFS_TGT \
	--prefix=$LFS/tools \
	--with-glibc-version=2.38 \
	--with-sysroot=$LFS \
	--with-newlib \
	--without-headers \
	--enable-default-pie \
	--enable-default-ssp \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++

# build gcc
make

# install gcc
make install

# fake out a limits.h header
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	$(dirname $($LFS_TGT-gcc -print-libgcc-file-name))/include/limits.h

# remove sources
cd $TOPDIR
rm -rf gcc-13.2.0
