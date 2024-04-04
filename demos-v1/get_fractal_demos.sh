source config.env

if [ -z "${FRACTAL_DEMOS_V1_GIT}" ]; then
    FRACTAL_DEMOS_V1_GIT=main
fi

git clone --single-branch --branch $FRACTAL_DEMOS_V1_GIT https://github.com/fractal-analytics-platform/fractal-demos.git
mv fractal-demos fractal-demos-v1

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    check_exit_code "Cloning fractal-demos@$FRACTAL_DEMOS_V1_GIT (EXIT_CODE=$EXIT_CODE)"
    exit 1
fi
