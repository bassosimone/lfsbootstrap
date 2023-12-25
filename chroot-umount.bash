#!/bin/bash
set -euxo pipefail

# source configuration
. config.bash

# we need to tolerate errors when umounting
set +e

# unmount
mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}
