#!/bin/bash
set -euxo pipefail

# source configuration
. config.bash

# unmount
mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm || true
umount $LFS/dev/pts || true
umount $LFS/{sys,proc,run,dev} || true
