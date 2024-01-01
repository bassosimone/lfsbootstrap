#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# TODO: keep in sync with pkg-mkskel
util_create_skel() {
	local destdir=$1

	mkdir -pv $destdir/{etc,var} $destdir/usr/{bin,lib,sbin} $destdir/opt

	for i in bin lib sbin; do
		ln -sv usr/$i $destdir/$i
	done

	case $(uname -m) in
	x86_64)
		mkdir -pv $destdir/lib64
		;;
	esac
}

util_create_skel $LFS

# The following lines should only belong to stage1-001-create-skel.bash
install -d $LFS/var/lib/pkg-tools/manifest
(cd $LFS && find . -exec ls -dF {} \;) >MANIFEST
mv MANIFEST $LFS/var/lib/pkg-tools/manifest/aaa-skel-stage1.txt
mkdir -pv $LFS/tools
