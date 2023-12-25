#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# copy the script to run the setup
install -m755 stage2-009-python $LFS/

# run the setup script using the chroot login shell
./chroot-login-shell.bash /stage2-009-python

# remove the script
rm $LFS/stage2-009-python
