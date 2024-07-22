source config.env
echo "FRACTAL_CLIENT_V1_RELEASE=$FRACTAL_CLIENT_V1_RELEASE"
echo "FRACTAL_CLIENT_V1_GIT=$FRACTAL_CLIENT_V1_GIT"
if [ -z "${FRACTAL_CLIENT_V1_RELEASE}" ]; then
    if [ -z "${FRACTAL_CLIENT_V1_GIT}" ]; then
        # Case 1: no release, no git
        fractal-tasks-venv/bin/python -m pip install fractal-client
    else
        # Case 2: only git set
        fractal-tasks-venv/bin/python -m pip install git+https://github.com/fractal-analytics-platform/fractal-client.git@$FRACTAL_CLIENT_V1_GIT
        # Check exit code
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
            echo "Error: Installing fractal-client@$FRACTAL_CLIENT_V1_GIT (EXIT_CODE=$EXIT_CODE)"
            exit 1
        fi
    fi
else
    if [ -z "${FRACTAL_CLIENT_V1_GIT}" ]; then
        # Case 3: only release set
        fractal-tasks-venv/bin/python -m pip install fractal-client==$FRACTAL_CLIENT_V1_RELEASE
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_CLIENT_V1_RELEASE and FRACTAL_CLIENT_V1_GIT." && exit 1
    fi
fi
