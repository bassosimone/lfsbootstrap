#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# reset to end of the second stage
rm -rf $LFS
install -d $LFS
tar -C $LFS -xf stage2.tar
