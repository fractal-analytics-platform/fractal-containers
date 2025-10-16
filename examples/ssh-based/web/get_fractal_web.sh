#!/bin/sh

set -e

echo "FRACTAL_WEB_RELEASE=$FRACTAL_WEB_RELEASE"
echo "FRACTAL_WEB_GIT=$FRACTAL_WEB_GIT"
if [ -z "${FRACTAL_WEB_RELEASE}" ]; then
    if [ -z "${FRACTAL_WEB_GIT}" ]; then
        # Case 1: no release, no git
        echo "Error: must set one of FRACTAL_WEB_RELEASE or FRACTAL_WEB_GIT." && exit 1
    else
        # Case 2: only git set
        apk add git
        git clone -b "$FRACTAL_WEB_GIT" https://github.com/fractal-analytics-platform/fractal-web.git
        cd fractal-web
        npm install
        npm run build
    fi
else
    if [ -z "${FRACTAL_WEB_GIT}" ]; then
        # Case 3: only release set
        mkdir fractal-web
        cd fractal-web
        wget -qO- "https://github.com/fractal-analytics-platform/fractal-web/releases/download/v${FRACTAL_WEB_VERSION}/node-${NODE_MAJOR_VERSION}-fractal-web-v${FRACTAL_WEB_VERSION}.tar.gz" | tar -xz
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_WEB_RELEASE and FRACTAL_WEB_GIT." && exit 2
    fi
fi
