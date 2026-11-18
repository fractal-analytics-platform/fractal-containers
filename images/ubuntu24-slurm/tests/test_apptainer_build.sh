#!/bin/bash

set -eu

TESTS_DIR=$(cd "$(dirname "$0")" && pwd)
IMAGE=${1}

docker run --rm --hostname slurm \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --device /dev/fuse \
  -v "${TESTS_DIR}/test.def:/tmp/test.def:ro" \
  "${IMAGE}" \
  bash -c '
    set -eu
    cp /tmp/test.def /home/test01/test.def
    chown test01:test01 /home/test01/test.def
    cd /home/test01
    runuser -u test01 -- apptainer build test.sif test.def
    runuser -u test01 -- apptainer exec test.sif pixi --version | grep -q "pixi 0.80.0"
    runuser -u test01 -- apptainer exec test.sif cat /hello.txt | grep -q "Hello, world!"
  '
