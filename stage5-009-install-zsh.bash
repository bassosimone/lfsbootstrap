#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# download openssl sources
curl -fsSLO https://www.zsh.org/pub/zsh-5.9.tar.xz

# verify download
cat >MD5SUMS <<"EOF"
182e37ca3fe3fa6a44f69ad462c5c30e zsh-5.9.tar.xz
EOF
md5sum -c MD5SUMS
rm -f MD5SUMS

# move the sources into /usr/src
install -m644 zsh-5.9.tar.xz $LFS/usr/src/
rm zsh-5.9.tar.xz

# run curl build script inside the chroot
./chroot-copy-and-exec.bash stage5-009-install-zsh
