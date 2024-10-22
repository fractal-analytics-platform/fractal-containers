FROM python:3.10-slim

RUN apt update
RUN apt install -y wget ssh sshpass

ARG FRACTAL_SERVER_VERSION

RUN echo "Install fractal-server ${FRACTAL_SERVER_VERSION}"
RUN pip3 install fractal-server[gunicorn,postgres-psycopg-binary]==${FRACTAL_SERVER_VERSION}

# RUN apt install wget -y
RUN wget https://github.com/fractal-analytics-platform/fractal-server/raw/main/tests/v2/fractal_tasks_mock/dist/fractal_tasks_mock-0.0.1-py3-none-any.whl

COPY setup_ssh_keys_and_run_server.sh ./
COPY .fractal_server.env ./
COPY slurm_config.json ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

ENTRYPOINT ["bash", "setup_ssh_keys_and_run_server.sh"]
