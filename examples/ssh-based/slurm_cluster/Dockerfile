FROM ghcr.io/fractal-analytics-platform/ubuntu24-slurm:0.1

RUN apt update
RUN apt install -y git

ARG FRACTAL_SERVER_RELEASE
ARG FRACTAL_SERVER_GIT
ARG SLURM_CPUS
ARG SLURM_MEMORY

RUN echo "Install fractal-server ${FRACTAL_SERVER_RELEASE} or ${FRACTAL_SERVER_GIT}"
COPY get_fractal_server.sh ./
RUN chmod +x ./get_fractal_server.sh
RUN python3 -m venv /fractal-server-venv
RUN ./get_fractal_server.sh

RUN sed -i "s/CPUs=[0-9]*/CPUs=${SLURM_CPUS}/g" /etc/slurm/slurm.conf
RUN sed -i "s/RealMemory=[0-9]*/RealMemory=${SLURM_MEMORY}/g" /etc/slurm/slurm.conf

RUN mkdir -p /data/remote/tasks/
RUN mkdir -p /data/remote/jobs/
RUN chown test01:test01 /data/remote/tasks/
RUN chown test01:test01 /data/remote/jobs/

# Append a `tail -f` command to the entrypoint, to make it hang
RUN echo "tail -f" >> "/etc/slurm/docker-entrypoint.sh"

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
