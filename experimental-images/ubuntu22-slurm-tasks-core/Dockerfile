FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

RUN python3 -m venv fractal-tasks-venv
RUN fractal-tasks-venv/bin/python -m pip install fractal-tasks-core[fractal-tasks]

CMD [ "tail","-f" ]
