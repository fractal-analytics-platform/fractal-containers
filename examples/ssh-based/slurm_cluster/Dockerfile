FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

ARG FRACTAL_SERVER_VERSION
ARG SLURM_CPUS
ARG SLURM_MEMORY

RUN echo "Install fractal-server ${FRACTAL_SERVER_VERSION}"
RUN pip3 install fractal-server[gunicorn,postgres-psycopg-binary]==${FRACTAL_SERVER_VERSION}

RUN sed -i "s/CPUs=[0-9]*/CPUs=${SLURM_CPUS}/g" /etc/slurm/slurm.conf
RUN sed -i "s/RealMemory=[0-9]*/RealMemory=${SLURM_MEMORY}/g" /etc/slurm/slurm.conf

RUN mkdir -p /data/remote/tasks/
RUN mkdir -p /data/remote/jobs/
RUN chown test01:test01 /data/remote/tasks/
RUN chown test01:test01 /data/remote/jobs/

# Append a `tail -f` command to the entrypoint, to make it hang
RUN echo "tail -f" >> "/etc/slurm/docker-entrypoint.sh"

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
