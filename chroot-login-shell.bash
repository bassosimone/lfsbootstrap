#!/bin/bash
set -euxo pipefail

# read configuration
. config.bash

# enter into the chroot
chroot "$LFS" /usr/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='(lfs chroot) \u:\w\$ ' \
	PATH=/usr/bin:/usr/sbin \
	/bin/bash --login "$@"
