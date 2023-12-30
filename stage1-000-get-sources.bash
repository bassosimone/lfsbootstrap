#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# create tarballs
install -d tarballs

# download the list of files to download and the MD5s in $LFS/usr/src
cd tarballs
curl -fsSLO https://www.linuxfromscratch.org/lfs/view/stable-systemd/wget-list-systemd
curl -fsSLO https://www.linuxfromscratch.org/lfs/view/stable-systemd/md5sums

# download all the files
wget --input-file=wget-list-systemd --continue

# verify the MD5s
md5sum -c md5sums
