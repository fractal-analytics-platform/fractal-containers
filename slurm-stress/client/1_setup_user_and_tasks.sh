#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

###############################################################################
# IMPORTANT: This defines the location of input & output data
# Set cache path and remove any previous file from there
FRACTAL_CACHE_PATH=$(pwd)/".cache"
export FRACTAL_CACHE_PATH="$FRACTAL_CACHE_PATH"
if [ -d "$FRACTAL_CACHE_PATH" ]; then
    rm -rv "$FRACTAL_CACHE_PATH"  2> /dev/null
fi

###############################################################################

WHEEL_PATH=/home/admin/fractal_tasks_mock-0.0.1-py3-none-any.whl
fractal task collect $WHEEL_PATH
echo "Task collection started"

###############################################################################

echo "Now edit the user's properties"
fractal user edit 1 --new-cache-dir /home/fractal_share/test01-cache/ --new-slurm-user test01
echo "Done"
