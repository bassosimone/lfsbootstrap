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
manifest=$LFS/var/lib/pkg-tools/manifest/pkg-tools-12.0.0.txt
install -d $(dirname $manifest)
for tool in ${tools[@]}; do
	install $tool $LFS/sbin
done

# register installation
rm -f $manifest
for tool in ${tools[@]}; do
	(cd $LFS && find "./sbin/$tool" -ls) >>$manifest
done
