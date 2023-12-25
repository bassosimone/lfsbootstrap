#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# create an archive
tar -C rootfs -cf stage1.tar .
