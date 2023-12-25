#!/bin/bash
set -euxo pipefail

# read configuration
. config.bash

# mount kernel file systems
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

# do we need to mount /dev/shm?
if [ -h $LFS/dev/shm ]; then
	mkdir -pv $LFS/$(readlink $LFS/dev/shm)
else
	mount -t tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi
