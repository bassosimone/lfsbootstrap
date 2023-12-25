#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

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

	mkdir -pv $destdir/tools
}

util_create_skel $LFS
