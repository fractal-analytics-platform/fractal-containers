export $(grep -v '^#' config_env.sh | xargs)
export FRACTAL_SERVER_RELEASE=asdasd

echo "FRACTAL_SERVER_RELEASE: $FRACTAL_SERVER_RELEASE"
echo "FRACTAL_SERVER_GIT: $FRACTAL_SERVER_GIT"

pip install fractal-server[postgres,gunicorn]==1.3.8a3
