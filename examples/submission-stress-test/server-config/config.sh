#!/bin/bash

# Collect tasks - not required for demo purposes but could be useful having the command here
fractal task collect /fractal_tasks_mock-0.0.1-py3-none-any.whl

# Update user
FRACTAL_USER_ID=$(fractal --batch user whoami)
fractal user edit "$FRACTAL_USER_ID" --new-project-dir /home/test01 --new-slurm-user test01

# Create folders and change permissions
mkdir -p /data/images/
mkdir -p /data/zarrs/
chmod 777 /data/images/ --recursive
chmod 777 /data/zarrs/ --recursive
