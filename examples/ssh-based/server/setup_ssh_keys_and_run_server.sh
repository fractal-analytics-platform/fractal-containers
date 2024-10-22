#!/bin/bash

SSH_HOST=$(nslookup slurm | grep Address | tail -n 1 | cut -d' ' -f2)
SSH_USER="test01"
SSH_PRIVATE_KEY_FILE="/ssh_key_test01.key"
SSH_PUBLIC_KEY_FILE="/ssh_key_test01.key.pub"
echo "pre-keygen"
ssh-keygen -t rsa -f "$SSH_PRIVATE_KEY_FILE" -N ""
echo test01 > pwd.txt
echo "pre-ssh-copy-id"
echo sshpass -f pwd.txt ssh-copy-id -f -i "$SSH_PUBLIC_KEY_FILE" "${SSH_USER}@${SSH_HOST}"
echo "pre-whoami"
ssh -i "$SSH_PRIVATE_KEY_FILE" "${SSH_USER}@${SSH_HOST}" whoami

fractalctl set-db
gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile logs-fractal-server.access \
    --error-logfile logs-fractal-server.error \
    --worker-class uvicorn.workers.UvicornWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
