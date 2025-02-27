FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

ARG FRACTAL_SERVER_VERSION

RUN echo "Install fractal-server ${FRACTAL_SERVER_VERSION}"
RUN pip3 install fractal-server==${FRACTAL_SERVER_VERSION}

COPY run_server.sh ./
COPY .fractal_server.env ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

ENTRYPOINT ["bash", "run_server.sh"]
