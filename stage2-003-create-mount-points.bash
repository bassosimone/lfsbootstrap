#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# create missing directories for mounting kernel virtual filesystems
mkdir -pv $LFS/{dev,proc,run,sys}
