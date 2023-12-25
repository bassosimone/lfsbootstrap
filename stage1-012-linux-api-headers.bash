#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# unpack linux
tar -xf $LFS/usr/src/linux-6.4.12.tar.xz

# enter into sources dir
cd linux-6.4.12

# make sure everything is clean
make mrproper

# install the headers
make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr

# remove sources
cd $TOPDIR
rm -rf linux-6.4.12
