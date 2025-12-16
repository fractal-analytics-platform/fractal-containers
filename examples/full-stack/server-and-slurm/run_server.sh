#!/bin/bash

set -eu

# Activate SLURM, by running the entrypoint of the base image
/etc/slurm/docker-entrypoint.sh

# shellcheck disable=SC1091
source /venv-server/bin/activate

fractalctl set-db

fractalctl init-db-data \
    --resource resource.json --profile profile.json \
    --admin-email admin@example.org --admin-pwd 1234 \
    --admin-project-dir /data/zarrs/test01

gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile - \
    --error-logfile - \
    --worker-class uvicorn.workers.UvicornWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
