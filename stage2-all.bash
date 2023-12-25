#!/bin/bash
set -euxo pipefail
for script in stage2-*.bash; do
	test -x ./$script && time ./$script
done
