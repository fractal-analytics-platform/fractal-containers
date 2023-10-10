git clone https://github.com/fractal-analytics-platform/fractal-demos.git

source config.env

echo "FRACTAL_DEMOS_GIT=$FRACTAL_DEMOS_GIT"
if [ ! -z "${FRACTAL_DEMOS_GIT}" ]; then
    cd fractal-demos
    git checkout $FRACTAL_DEMOS_GIT
    
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        echo "Error: EXIT_CODE=$EXIT_CODE"
        exit 1
    fi
    
    cd ..
fi
