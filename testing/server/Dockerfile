FROM ghcr.io/fractal-analytics-platform/ubuntu24-slurm-multipy:0.1

# User specific cpu count and memory for slurm configuration
ARG SLURM_CPUS
ARG SLURM_MEMORY
RUN sed -i "s/CPUs=[0-9]*/CPUs=${SLURM_CPUS}/g" /etc/slurm/slurm.conf
RUN sed -i "s/RealMemory=[0-9]*/RealMemory=${SLURM_MEMORY}/g" /etc/slurm/slurm.conf

RUN apt update && apt install -y git curl
RUN apt install -y libgles2

# Install fractal-server
RUN python3.12 -m venv /fractal-server-venv-py3.12
ADD config.env .
COPY server/get_fractal_server.sh .
RUN bash get_fractal_server.sh

ENV PIP_DEFAULT_TIMEOUT=

RUN mkdir -p /home/fractal_share/
RUN chmod -R 777 /home/fractal_share/

COPY server/server.env ./.fractal_server.env
COPY server/resource.json ./
COPY server/profile.json ./

# Launch command
CMD /fractal-server-venv-py3.12/bin/fractalctl set-db && \
    /fractal-server-venv-py3.12/bin/fractalctl init-db-data --resource resource.json --profile profile.json --admin-email admin@example.org --admin-pwd 1234 --admin-project-dir /home/test01 && \
    /fractal-server-venv-py3.12/bin/gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile - \
    --error-logfile - \
    --worker-class fractal_server.gunicorn_fractal.FractalWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
