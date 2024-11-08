#!/bin/bash

SSH_HOST=slurm
SSH_USER="test01"
SSH_PRIVATE_KEY_FILE="/ssh_key_test01.key"
SSH_PUBLIC_KEY_FILE="/ssh_key_test01.key.pub"

# Add 'slurm' host to known ones
ssh-keyscan slurm >> ~/.ssh/known_hosts

# Generate key pair and copy ID to 'slurm'
ssh-keygen -t rsa -f "$SSH_PRIVATE_KEY_FILE" -N ""
sshpass -v -p test01 ssh-copy-id -f -i "$SSH_PUBLIC_KEY_FILE" "${SSH_USER}@${SSH_HOST}"

# Run a simple command
ssh -i "$SSH_PRIVATE_KEY_FILE" "${SSH_USER}@${SSH_HOST}" whoami

fractalctl set-db
gunicorn fractal_server.main:app \
    --workers 4 \
    --timeout 100 \
    --bind 0.0.0.0:8000 \
    --access-logfile logs-fractal-server.access \
    --error-logfile logs-fractal-server.error \
    --worker-class uvicorn.workers.UvicornWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
