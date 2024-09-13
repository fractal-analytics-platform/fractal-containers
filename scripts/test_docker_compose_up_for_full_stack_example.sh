#!/bin/bash

set -e

# Note: this should run from the main repository folder

echo "Run docker compose up"
docker compose --file examples/full-stack/docker-compose.yml up --detach

SLEEPTIME=120

echo "Now sleep $SLEEPTIME seconds"
echo
sleep "$SLEEPTIME"


echo "Current docker ps"
echo
docker ps
echo

echo "Start checks"
echo

# Count "running" Docker services
RUNNING_SERVICES=$(docker ps --filter 'status=running' --quiet | wc -l)
if [ "$RUNNING_SERVICES" = "5" ]; then
    echo "Number of running services is as expected."
else
    echo "Unexpected number of running services ($RUNNING_SERVICES), exit 1."
    exit 1
fi

# Count "exited" Docker services
EXITED_SERVICES=$(docker ps --filter 'status=exited' --quiet | wc -l)
if [ "$EXITED_SERVICES" = "1" ]; then
    echo "Number of exited services is as expected."
  echo "All good up to here"
else
    echo "Unexpected number of exited services ($EXITED_SERVICES), exit 2."
    exit 2
fi
