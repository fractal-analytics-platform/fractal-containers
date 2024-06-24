FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

ARG FRACTAL_SERVER_VERSION

RUN pip3 install fractal-server[gunicorn,postgres-psycopg-binary]==$FRACTAL_SERVER_VERSION

COPY run_server.sh ./
COPY .fractal_server.env ./
COPY slurm_config.json ./
EXPOSE 8000
CMD [ "./run_server.sh" ]
