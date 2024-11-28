#!/bin/bash

echo "FRACTAL_SERVER_RELEASE=$FRACTAL_SERVER_RELEASE"
echo "FRACTAL_SERVER_GIT=$FRACTAL_SERVER_GIT"

if [ -z "${FRACTAL_SERVER_RELEASE}" ]; then
    if [ -z "${FRACTAL_SERVER_GIT}" ]; then
        # Case 1: no release, no git
        python3 -m pip install "fractal-server"
    else
        # Case 2: only git set
        python3 -m pip install "fractal-server @ git+https://github.com/fractal-analytics-platform/fractal-server.git@${FRACTAL_SERVER_GIT}"
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
            echo "Error: Installing fractal-server@$FRACTAL_SERVER_GIT (EXIT_CODE=$EXIT_CODE)"
            exit 1
        fi
    fi
else
    if [ -z "${FRACTAL_SERVER_GIT}" ]; then
        # Case 3: only release set
        python3 -m pip install "fractal-server==$FRACTAL_SERVER_RELEASE"
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_SERVER_RELEASE and FRACTAL_SERVER_GIT." && exit 1
    fi
fi
