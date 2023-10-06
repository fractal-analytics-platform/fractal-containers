git clone https://github.com/fractal-analytics-platform/fractal-web.git

source config.env

echo "FRACTAL_WEB_GIT=$FRACTAL_WEB_GIT"
if [ ! -z "${FRACTAL_WEB_GIT}" ]; then
    cd fractal-web
    git checkout $FRACTAL_WEB_GIT
    cd ..
fi
