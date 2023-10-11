source config.env

if [ -z "${FRACTAL_DEMOS_GIT}" ]; then
    FRACTAL_DEMOS_GIT=main
fi

git clone --single-branch --branch $FRACTAL_DEMOS_GIT https://github.com/fractal-analytics-platform/fractal-demos.git

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    check_exit_code "Cloning fractal-demos@$FRACTAL_DEMOS_GIT (EXIT_CODE=$EXIT_CODE)"
    exit 1
fi
