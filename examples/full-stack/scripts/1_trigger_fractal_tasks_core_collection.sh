#!/bin/bash

# Set cache path to the local directory, remove it if it exists
FRACTAL_CACHE_PATH=$(pwd)/".cache"
export FRACTAL_CACHE_PATH="$FRACTAL_CACHE_PATH"
if [ -d "$FRACTAL_CACHE_PATH" ]; then
    rm -rv "$FRACTAL_CACHE_PATH"  2> /dev/null
fi

fractal task collect fractal-tasks-core --package-extras fractal-tasks
