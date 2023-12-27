#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# reset to end of the fourth stage
rm -rf $LFS
install -d $LFS
tar -C $LFS -xf stage4.tar
