#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# download curl sources
curl -fsSLO https://curl.se/download/curl-8.2.1.tar.xz

# verify download
cat >MD5SUMS <<"EOF"
556576a795bdd2c7d10de6886480065f curl-8.2.1.tar.xz
EOF
md5sum -c MD5SUMS
rm -f MD5SUMS

# move the sources into /usr/src
install -m644 curl-8.2.1.tar.xz $LFS/usr/src/
rm curl-8.2.1.tar.xz

# run curl build script inside the chroot
./chroot-copy-and-exec.bash stage5-005-install-curl
