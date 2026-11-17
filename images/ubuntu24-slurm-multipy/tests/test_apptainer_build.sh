#!/bin/bash

set -eu

TESTS_DIR=$(cd "$(dirname "$0")" && pwd)

docker run --rm --hostname slurm \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --device /dev/fuse \
  -v "$TESTS_DIR/test.def:/tmp/test.def:ro" \
  ghcr.io/fractal-analytics-platform/ubuntu24-slurm-multipy:0.1 \
  bash -c '
    set -eu
    install -o test01 -g test01 /tmp/test.def /home/test01/test.def
    runuser -l test01 -c "
      set -eu
      apptainer build test.sif test.def
      apptainer exec test.sif pixi --version | grep -q \"pixi 0.80.0\"
      apptainer exec test.sif cat /hello.txt | grep -q \"Hello, world!\"
    "
  '
