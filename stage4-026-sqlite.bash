#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# download openssl sources
curl -fsSLO https://sqlite.org/2023/sqlite-autoconf-3420000.tar.gz

# verify download
cat >MD5SUMS <<"EOF"
0c5a92bc51cf07cae45b4a1e94653dea sqlite-autoconf-3420000.tar.gz
EOF
md5sum -c MD5SUMS
rm -f MD5SUMS

# move the sources into /usr/src
install -m644 sqlite-autoconf-3420000.tar.gz $LFS/usr/src/
rm sqlite-autoconf-3420000.tar.gz

# run curl build script inside the chroot
./chroot-copy-and-exec.bash stage4-026-sqlite
