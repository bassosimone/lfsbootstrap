#!/bin/bash
set -euxo pipefail

# read the configuration
. config.bash

# create tarballs
install -d tarballs
cd tarballs

# download all the files
for URL in $(cat ../wget-list-systemd); do
	filename=$(basename $URL)
	if [[ ! -f $filename ]]; then
		curl -fsSLO $URL
	fi
done

# verify the checksum
shasum -c ../SHA256SUMS
