FROM ubuntu:22.04

RUN apt update -y
RUN apt install -y wget vim less python3 python3-pip python3-venv

ARG FRACTAL_SERVER_VERSION
RUN pip3 install fractal-server==${FRACTAL_SERVER_VERSION}

COPY run_server.sh ./
COPY .fractal_server.env ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

ENTRYPOINT ["bash", "run_server.sh"]
