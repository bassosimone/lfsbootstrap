#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

tools=(
	pkg-install
	pkg-mkmanifest
	pkg-mkskel
)

# install pkg-tools
manifest=$LFS/var/lib/pkg-tools/manifest/pkg-tools-12.0.20240101.txt
install -d $(dirname $manifest)
for tool in ${tools[@]}; do
	install $tool $LFS/sbin
done

# register installation
rm -f $manifest
for tool in ${tools[@]}; do
	(cd $LFS && find "./usr/sbin/$tool" -exec ls -dF {} \;) >>$manifest
done
