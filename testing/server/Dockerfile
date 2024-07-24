FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm-tasks-core:0.1

# setting up DB configuration
COPY server/server.env ./.fractal_server.env

# Install fractal-server
ADD config.env .
COPY server/get_fractal_server.sh .
RUN bash get_fractal_server.sh

ENV PIP_DEFAULT_TIMEOUT=100

# launch command
CMD fractalctl set-db && \
    gunicorn fractal_server.main:app \
    --workers 2 \
    --timeout 20 \
    --bind 0.0.0.0:8000 \
    --access-logfile logs-fractal-server.access \
    --error-logfile logs-fractal-server.error \
    --worker-class fractal_server.gunicorn_fractal.FractalWorker \
    --logger-class fractal_server.gunicorn_fractal.FractalGunicornLogger