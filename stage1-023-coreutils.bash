#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack coreutils
tar -xf $LFS/usr/src/coreutils-9.3.tar.xz

# enter into sources dir
cd coreutils-9.3

# configure coreutils
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--enable-install-program=hostname \
	--enable-no-install-program=kill,uptime \
	gl_cv_macro_MB_CUR_MAX_good=y

# build coreutils
make

# install coreutils
make DESTDIR=$LFS install

# adjust the install location
mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8

# remove sources
cd $TOPDIR
rm -rf coreutils-9.3
