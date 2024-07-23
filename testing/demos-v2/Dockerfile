FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm-tasks-core:0.1

ARG FRACTAL_SERVER_VERSION

ADD config.env .

COPY demos-v2/get_fractal_client.sh .
RUN bash get_fractal_client.sh

COPY demos-v2/get_fractal_demos.sh .
RUN bash get_fractal_demos.sh

ADD config.env ./fractal-demos-v2/examples/config.env
COPY demos-v2/get_fractal_tasks_core.sh ./fractal-demos-v2/examples/get_fractal_tasks_core.sh
ADD demos-v2/fractal.env ./fractal-demos-v2/examples/.fractal.env
ADD demos-v2/run_demos.sh ./fractal-demos-v2/examples/run_demos.sh

RUN fractal-tasks-venv/bin/python -m pip install fractal-server[gunicorn,postgres-psycopg-binary]==${FRACTAL_SERVER_VERSION}

COPY run_server.sh ./
COPY .fractal_server.env ./
COPY slurm_config.json ./
