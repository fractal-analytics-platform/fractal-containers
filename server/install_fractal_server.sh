# export $(grep -v '^#' config_env.sh | xargs)
source config.env

echo "FRACTAL_SERVER_RELEASE: $FRACTAL_SERVER_RELEASE"
echo "FRACTAL_SERVER_GIT: $FRACTAL_SERVER_GIT"

pip install fractal-server[postgres,gunicorn]==$FRACTAL_SERVER_RELEASE
