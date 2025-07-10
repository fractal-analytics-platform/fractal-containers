#!/bin/bash

source /venv-server/bin/activate

fractalctl set-db

gunicorn fractal_server.main:app \
    --workers 3 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile - \
    --error-logfile - \
    --worker-class uvicorn.workers.UvicornWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
