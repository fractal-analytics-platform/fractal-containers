#!/bin/bash

set -e

# Note: this should run from the main repository folder

echo "Run docker compose up"
docker compose --file examples/full-stack/docker-compose.yml up --detach

SLEEPTIME=15

echo "Now sleep $SLEEPTIME seconds"
echo
sleep "$SLEEPTIME"

echo "Current docker ps"
echo
docker ps
echo


echo "Start checks"
echo

FRACTAL_SERVER_ALIVE_ENDPOINT="http://localhost:8000/api/alive/"
FRACTAL_SERVER_ALIVE_RESPONSE_FILE=response.json
curl --silent --show-error --output "$FRACTAL_SERVER_ALIVE_RESPONSE_FILE" "$FRACTAL_SERVER_ALIVE_ENDPOINT"

if grep "\"alive\":true" "$FRACTAL_SERVER_ALIVE_RESPONSE_FILE" > /dev/null; then
    echo "All good"
    cat "$FRACTAL_SERVER_ALIVE_RESPONSE_FILE"
    echo
else
    echo "Unexpected response from $FRACTAL_SERVER_ALIVE_ENDPOINT:"
    cat "$FRACTAL_SERVER_ALIVE_RESPONSE_FILE"
    echo
    exit 1
fi
