#!/bin/bash
set -euxo pipefail
for script in stage3-*.bash; do
	test -x ./$script && time ./$script
done
