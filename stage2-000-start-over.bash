#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# reset to end of the first stage
rm -rf $LFS
install -d $LFS
tar -C $LFS -xf stage1.tar
