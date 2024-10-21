#!/bin/bash

SSH_HOST=$(nslookup slurm | grep Address | tail -n 1 | cut -d' ' -f2)
SSH_USER="test01"
SSH_KEY_FILE="/ssh_key_test01.key"
ssh-keygen -t rsa -f "$SSH_KEY_FILE" -N ""
echo "yes\ntest01" | ssh-copy-id -i "$SSH_KEY_FILE" "${SSH_USER}@${SSH_HOST}"

fractalctl set-db
gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile logs-fractal-server.access \
    --error-logfile logs-fractal-server.error \
    --worker-class uvicorn.workers.UvicornWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
