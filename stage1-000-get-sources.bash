#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# create tarballs
install -d tarballs
cd tarballs

# download all the files
wget --input-file=../wget-list-systemd --continue

# verify the checksum
shasum -a 256 ../SHA256SUMS
