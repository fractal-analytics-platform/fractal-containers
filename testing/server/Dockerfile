FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm-multipy:0.1

# User specific cpu count and memory for slurm configuration
ARG SLURM_CPUS
ARG SLURM_MEMORY
RUN sed -i "s/CPUs=[0-9]*/CPUs=${SLURM_CPUS}/g" /etc/slurm/slurm.conf
RUN sed -i "s/RealMemory=[0-9]*/RealMemory=${SLURM_MEMORY}/g" /etc/slurm/slurm.conf

RUN apt update && apt install -y git curl
RUN apt install -y libgles2

# setting up DB configuration
COPY server/server.env ./.fractal_server.env
COPY server/slurm_config.json ./

# Install fractal-server
ADD config.env .
COPY server/get_fractal_server.sh .
RUN bash get_fractal_server.sh

ENV PIP_DEFAULT_TIMEOUT=

RUN mkdir -p /home/fractal_share/
RUN chmod -R 777 /home/fractal_share/

# Launch command
CMD fractalctl set-db && \
    gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile logs-fractal-server.access \
    --error-logfile logs-fractal-server.error \
    --worker-class fractal_server.gunicorn_fractal.FractalWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger
