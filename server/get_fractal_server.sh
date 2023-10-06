source config.env
echo "FRACTAL_SERVER_RELEASE=$FRACTAL_SERVER_RELEASE"
echo "FRACTAL_SERVER_GIT=$FRACTAL_SERVER_GIT"
if [ -z "${FRACTAL_SERVER_RELEASE}" ]; then
    if [ -z "${FRACTAL_SERVER_GIT}" ]; then
        # Case 1: no release, no git
        python3 -m pip install fractal-server[postgres]
    else
        # Case 2: only git set
        echo "FRACTAL_SERVER_GIT not supported" && exit 1
    fi
else
    if [ -z "${FRACTAL_SERVER_GIT}" ]; then
        # Case 3: only release set
        python3 -m pip install fractal-server[postgres]==$FRACTAL_SERVER_RELEASE
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_SERVER_RELEASE and FRACTAL_SERVER_GIT." && exit 1
    fi
fi
