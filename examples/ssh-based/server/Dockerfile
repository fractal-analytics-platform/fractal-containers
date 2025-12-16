FROM python:3.11-slim

RUN apt update
RUN apt install -y wget ssh sshpass git

ARG FRACTAL_SERVER_RELEASE
ARG FRACTAL_SERVER_GIT

RUN echo "Install fractal-server ${FRACTAL_SERVER_RELEASE} or ${FRACTAL_SERVER_GIT}"
COPY get_fractal_server.sh ./
RUN chmod +x ./get_fractal_server.sh
RUN ./get_fractal_server.sh

COPY setup_ssh_keys_and_run_server.sh ./
COPY .fractal_server.env ./
COPY resource.json ./
COPY profile.json ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

ENTRYPOINT ["bash", "setup_ssh_keys_and_run_server.sh"]
