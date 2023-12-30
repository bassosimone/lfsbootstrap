#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# create missing directories for mounting kernel virtual filesystems
mkdir -pv $LFS/{dev,proc,run,sys}

# register the creation of mountpoints
(cd $LFS && find ./dev ./proc ./run ./sys -exec ls -dF {} \;) \
	>$LFS/var/lib/pkg-tools/manifest/aaa-mountpoints.txt
