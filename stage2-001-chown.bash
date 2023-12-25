#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# give ownership to root:root
chown -R root:root $LFS
