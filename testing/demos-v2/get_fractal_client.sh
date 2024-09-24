source config.env
echo "FRACTAL_CLIENT_V2_RELEASE=$FRACTAL_CLIENT_V2_RELEASE"
echo "FRACTAL_CLIENT_V2_GIT=$FRACTAL_CLIENT_V2_GIT"
if [ -z "${FRACTAL_CLIENT_V2_RELEASE}" ]; then
    if [ -z "${FRACTAL_CLIENT_V2_GIT}" ]; then
        # Case 1: no release, no git
        python3 -m pip install fractal-client
    else
        # Case 2: only git set
        python3 -m pip install git+https://github.com/fractal-analytics-platform/fractal-client.git@$FRACTAL_CLIENT_V2_GIT
        # Check exit code
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
            echo "Error: Installing fractal-client@$FRACTAL_CLIENT_V2_GIT (EXIT_CODE=$EXIT_CODE)"
            exit 1
        fi
    fi
else
    if [ -z "${FRACTAL_CLIENT_V2_GIT}" ]; then
        # Case 3: only release set
        python3 -m pip install "fractal-client==$FRACTAL_CLIENT_V2_RELEASE"
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_CLIENT_V2_RELEASE and FRACTAL_CLIENT_V2_GIT." && exit 1
    fi
fi
