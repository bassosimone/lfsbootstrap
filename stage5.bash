#!/bin/bash
set -euxo pipefail
for script in stage5-*.bash; do
	test -x ./$script && time ./$script
done
