FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm-tasks-core:0.1

ARG FRACTAL_SERVER_VERSION

ADD config.env .

COPY demos-v1/get_fractal_client.sh .
RUN bash get_fractal_client.sh

COPY demos-v1/get_fractal_demos.sh .
RUN bash get_fractal_demos.sh

ADD config.env ./fractal-demos-v1/examples/config.env
COPY demos-v1/get_fractal_tasks_core.sh ./fractal-demos-v1/examples/get_fractal_tasks_core.sh
ADD demos-v1/fractal.env ./fractal-demos-v1/examples/.fractal.env
ADD demos-v1/run_demos.sh ./fractal-demos-v1/examples/run_demos.sh

RUN fractal-tasks-venv/bin/python -m pip install fractal-server[gunicorn,postgres-psycopg-binary]==${FRACTAL_SERVER_VERSION}

COPY demos-v1/run_server.sh ./
COPY demos-v1/.fractal_server.env ./
COPY demos-v1/slurm_config.json ./

