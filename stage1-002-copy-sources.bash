#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# copy souces
cp -Rv ./tarballs $LFS/usr/src
