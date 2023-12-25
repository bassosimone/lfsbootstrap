#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# copy the script to run the setup
install -m755 stage2-005-setup $LFS/

# run the setup script using the chroot login shell
./chroot-login-shell.bash /stage2-005-setup

# remove the script
rm $LFS/stage2-005-setup
