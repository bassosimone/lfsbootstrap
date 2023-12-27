#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# download openssl sources
curl -fsSLO https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.4p1.tar.gz

# verify download
cat >MD5SUMS <<"EOF"
4bbd56a7ba51b0cd61debe8f9e77f8bb openssh-9.4p1.tar.gz
EOF
md5sum -c MD5SUMS
rm -f MD5SUMS

# move the sources into /usr/src
install -m644 openssh-9.4p1.tar.gz $LFS/usr/src/
rm openssh-9.4p1.tar.gz

# run curl build script inside the chroot
./chroot-copy-and-exec.bash stage5-006-install-openssh
