#!/bin/bash
set -euo pipefail

# make sure we have a formula to build
if [[ $# != 1 ]]; then
	echo "usage: $0 NAME" 1>&2
	exit 1
fi

set -x

# get the formula name
name=${1##pkg-build-}

# figure out the next number
lastnum=$(ls stage4-*.bash | tail -n1 | awk -F- '{print $2}' | sed 's/^0*//g')
nextnum=$(printf "%03d" $(($lastnum + 1)))

# compute bash file name
bashfile="stage4-$nextnum-$name.bash"

# compute extension-less file name
extless=${bashfile%%.bash}

ln -s chroot-copy-and-exec.bash $bashfile
ln -s pkg-build-$name $extless
