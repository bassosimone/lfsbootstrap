#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack glibc
tar -xf $LFS/usr/src/glibc-2.38.tar.xz

# enter into sources dir
cd glibc-2.38

# make sure we have symbolic links for the dynamic loader
case $(uname -m) in
i?86)
	ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
	;;
x86_64)
	ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
	ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
	;;
esac

# register that we installed symbolic links
(cd $LFS && find ./lib64 -ls) >$LFS/var/lib/pkg-tools/manifest/aaa-ld-so-symlinks-12.0.20231229.txt

# ensure FHS compliance
patch -Np1 -i $LFS/usr/src/glibc-2.38-fhs-1.patch

# create and enter into build dir
mkdir build
cd build

# use sbin for ldconfig and sln
echo "rootsbindir=/usr/sbin" >configparms

# configure glibc
../configure \
	--prefix=/usr \
	--host=$LFS_TGT \
	--build=$(../scripts/config.guess) \
	--enable-kernel=4.14 \
	--with-headers=$LFS/usr/include \
	libc_cv_slibdir=/usr/lib

# build glibc
make

# install glibc
make DESTDIR=$LFS install

# fix hardcoded path
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

# remove sources
cd $TOPDIR
rm -rf glibc-2.38
