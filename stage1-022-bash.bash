#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack bash
tar -xf $LFS/usr/src/bash-5.2.15.tar.gz

# enter into sources dir
cd bash-5.2.15

# configure bash
./configure --prefix=/usr \
	--build=$(sh support/config.guess) \
	--host=$LFS_TGT \
	--without-bash-malloc

# build bash
make

# install bash
make DESTDIR=$LFS install

# create symbolic link for sh
ln -sfv bash $LFS/bin/sh

# register that we created a symbolic link for sh
(cd $LFS && find ./usr/bin/sh -exec ls -dF {} \;) \
	>$LFS/var/lib/pkg-tools/manifest/aaa-bin-sh-symlink-12.0.20231229.txt

# remove sources
cd $TOPDIR
rm -rf bash-5.2.15
