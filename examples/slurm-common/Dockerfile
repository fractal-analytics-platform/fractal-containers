FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm-multipy:0.1

ARG FRACTAL_SERVER_VERSION
ARG SLURM_CPUS
ARG SLURM_MEMORY

RUN echo "Install fractal-server ${FRACTAL_SERVER_VERSION}"
RUN python3 -m venv /venv-server
RUN /venv-server/bin/python3 -m pip install fractal-server==${FRACTAL_SERVER_VERSION}

COPY run_server.sh ./
COPY .fractal_server.env ./
COPY slurm_config.json ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

RUN sed -i "s/CPUs=[0-9]*/CPUs=${SLURM_CPUS}/g" /etc/slurm/slurm.conf
RUN sed -i "s/RealMemory=[0-9]*/RealMemory=${SLURM_MEMORY}/g" /etc/slurm/slurm.conf

ENTRYPOINT ["bash", "run_server.sh"]
