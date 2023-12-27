#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# download openssl sources
curl -fsSLO https://www.kernel.org/pub/software/scm/git/git-2.41.0.tar.xz

# verify download
cat >MD5SUMS <<"EOF"
c1f58a12b891ad73927b8e4a3aa29c7b git-2.41.0.tar.xz
EOF
md5sum -c MD5SUMS
rm -f MD5SUMS

# move the sources into /usr/src
install -m644 git-2.41.0.tar.xz $LFS/usr/src/
rm git-2.41.0.tar.xz

# run curl build script inside the chroot
./chroot-copy-and-exec.bash stage5-007-install-git
