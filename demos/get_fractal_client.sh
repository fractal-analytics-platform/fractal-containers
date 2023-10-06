source config.env
echo "FRACTAL_CLIENT_RELEASE=$FRACTAL_CLIENT_RELEASE"
echo "FRACTAL_CLIENT_GIT=$FRACTAL_CLIENT_GIT"
if [ -z "${FRACTAL_CLIENT_RELEASE}" ]; then
    if [ -z "${FRACTAL_CLIENT_GIT}" ]; then
        # Case 1: no release, no git
        python3 -m pip install fractal-client
    else
        # Case 2: only git set  # TODO: add git support
        echo "FRACTAL_CLIENT_GIT not supported" && exit 1
    fi
else
    if [ -z "${FRACTAL_CLIENT_GIT}" ]; then
        # Case 3: only release set
        python3 -m pip install fractal-client==$FRACTAL_CLIENT_RELEASE
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_CLIENT_RELEASE and FRACTAL_CLIENT_GIT." && exit 1
    fi
fi