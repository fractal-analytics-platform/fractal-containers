#!/bin/bash

# Activate SLURM, by running the entrypoint of the base image
/etc/slurm/docker-entrypoint.sh

fractalctl set-db

gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile logs-fractal-server.access \
    --error-logfile logs-fractal-server.error \
    --worker-class uvicorn.workers.UvicornWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
