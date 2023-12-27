#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# download openssl sources
curl -fsSLO https://www.sudo.ws/dist/sudo-1.9.14p3.tar.gz

# verify download
cat >MD5SUMS <<"EOF"
4cc21cf7c9a89290b230954aed0d1e11 sudo-1.9.14p3.tar.gz
EOF
md5sum -c MD5SUMS
rm -f MD5SUMS

# move the sources into /usr/src
install -m644 sudo-1.9.14p3.tar.gz $LFS/usr/src/
rm sudo-1.9.14p3.tar.gz

# run curl build script inside the chroot
./chroot-copy-and-exec.bash stage5-008-install-sudo
