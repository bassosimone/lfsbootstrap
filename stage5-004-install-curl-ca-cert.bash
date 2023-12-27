#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# install the preconfigured cacert.pem
pkg_version=2023-12-12
install -m644 cacert-$pkg_version.pem $LFS/etc/ssl/cert.pem

# record that we installed this file
(cd $LFS && find ./etc/ssl/cert.pem -ls) >$LFS/var/lib/pkg-tools/manifest/curl-cacert-$pkg_version.txt
