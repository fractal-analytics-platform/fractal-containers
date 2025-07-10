FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y python3 python3-pip python3-venv curl

ARG FRACTAL_SERVER_VERSION

RUN echo "Install fractal-server ${FRACTAL_SERVER_VERSION}"
RUN python3 -m venv /venv-server
RUN /venv-server/bin/python3 -m pip install fractal-server==${FRACTAL_SERVER_VERSION}

RUN echo "Prepare base venv for Python3.12 tasks"
RUN python3 -m venv /.venv3.12

COPY run_server.sh ./
COPY .fractal_server.env ./

RUN mkdir -p /data/app/Tasks
RUN mkdir -p /data/app/Artifacts

ENTRYPOINT ["bash", "run_server.sh"]
