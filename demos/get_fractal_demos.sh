source config.env

if [ ! -z "${FRACTAL_DEMOS_GIT}" ]; then
    echo "FRACTAL_DEMOS_GIT=$FRACTAL_DEMOS_GIT"
    python3 -m pip install git+https://github.com/fractal-analytics-platform/fractal-demos.git@$FRACTAL_DEMOS_GIT
else
echo "FRACTAL_DEMOS_GIT=main"
    python3 -m pip install git+https://github.com/fractal-analytics-platform/fractal-demos.git
fi

# Check exit code
PIP_EXIT_CODE=$?
if [ $PIP_EXIT_CODE -ne 0 ]; then
    echo "Error: PIP_EXIT_CODE=$PIP_EXIT_CODE"
    exit 1
fi
