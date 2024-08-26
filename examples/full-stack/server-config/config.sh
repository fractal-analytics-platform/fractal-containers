#!/bin/bash

fractal task collect /fractal_tasks_mock-0.0.1-py3-none-any.whl

FRACTAL_USER_ID=$(fractal --batch user whoami )

fractal user edit $FRACTAL_USER_ID --new-cache-dir /home/test01 --new-slurm-user test01
