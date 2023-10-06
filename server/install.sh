source config.env

echo "FRACTAL_SERVER_RELEASE: $FRACTAL_SERVER_RELEASE"
echo "FRACTAL_SERVER_GIT: $FRACTAL_SERVER_GIT"

# FIXME add all logic for handling versions

pip install fractal-server[postgres]
