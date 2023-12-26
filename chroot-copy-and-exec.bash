#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# read file name
filename=$0

# obtain the name of the script to execute
script=${filename%%.bash}

# copy the script to run the setup
install -m755 $script $LFS/

# run the setup script using the chroot login shell
./chroot-login-shell.bash /$script

# remove the script
rm $LFS/$script
