#!/bin/bash
set -euxo pipefail
for script in stage1-*.bash; do
	test -x ./$script && time ./$script
done
