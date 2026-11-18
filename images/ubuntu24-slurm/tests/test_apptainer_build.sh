#!/bin/bash

set -eu

TESTS_DIR=$(cd "$(dirname "$0")" && pwd)
IMAGE=${1}
TEST_USER=test01
TEST_WORKDIR=/home/${TEST_USER}

docker run --rm --hostname slurm \
  --security-opt seccomp=unconfined \
  --security-opt apparmor=unconfined \
  --device /dev/fuse \
  -v "${TESTS_DIR}/test.def:${TEST_WORKDIR}/test.def:ro" \
  --user "${TEST_USER}" \
  --workdir "${TEST_WORKDIR}" \
  --entrypoint bash \
  "${IMAGE}" \
  -c '
    set -eu
    apptainer build test.sif test.def
    apptainer exec test.sif pixi --version | grep -q "pixi 0.80.0"
    apptainer exec test.sif cat /hello.txt | grep -q "Hello, world!"
  '
