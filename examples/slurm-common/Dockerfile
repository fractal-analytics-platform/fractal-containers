FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

ARG FRACTAL_SERVER_VERSION
ARG SLURM_CPUS
ARG SLURM_MEMORY

RUN pip3 install fractal-server[gunicorn,postgres-psycopg-binary]==${FRACTAL_SERVER_VERSION}

# RUN apt install wget -y
RUN wget https://github.com/fractal-analytics-platform/fractal-server/raw/main/tests/v2/fractal_tasks_mock/dist/fractal_tasks_mock-0.0.1-py3-none-any.whl

COPY run_server.sh ./
COPY .fractal_server.env ./
COPY slurm_config.json ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

RUN sed -i "s/CPUs=[0-9]*/CPUs=${SLURM_CPUS}/g" /etc/slurm/slurm.conf
RUN sed -i "s/RealMemory=[0-9]*/RealMemory=${SLURM_MEMORY}/g" /etc/slurm/slurm.conf

ENTRYPOINT ["bash", "run_server.sh"]
