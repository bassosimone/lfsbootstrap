#!/bin/bash
set -euxo pipefail
for script in stage4-*.bash; do
	test -x ./$script && time ./$script
done
