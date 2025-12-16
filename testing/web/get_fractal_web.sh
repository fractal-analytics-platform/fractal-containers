#!/bin/bash

git clone https://github.com/fractal-analytics-platform/fractal-web.git

# shellcheck disable=SC1091
source config.env

echo "FRACTAL_WEB_GIT=$FRACTAL_WEB_GIT"
if [ ! -z "${FRACTAL_WEB_GIT}" ]; then
    (
        # shellcheck disable=SC2164
        cd fractal-web
        git checkout "$FRACTAL_WEB_GIT"
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
            echo "Error: Checking out to fractal-web@$FRACTAL_WEB_GIT (EXIT_CODE=$EXIT_CODE)"
            exit 1
        fi
    )
else
    echo "FRACTAL_WEB_GIT variable is unset, use default branch."
fi
