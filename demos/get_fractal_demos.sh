git clone https://github.com/fractal-analytics-platform/fractal-demos.git

source config.env

echo "FRACTAL_DEMOS_GIT=$FRACTAL_DEMOS_GIT"
if [ ! -z "${FRACTAL_DEMOS_GIT}" ]; then
    cd fractal-demos
    git checkout $FRACTAL_DEMOS_GIT
    cd ..
fi
