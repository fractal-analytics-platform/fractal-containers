FROM ghcr.io/fractal-analytics-platform/ubuntu24-slurm:0.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt install -y python3.9 python3.9-distutils python3.9-venv

RUN apt install -y python3.11 python3.11-venv

RUN apt install -y python3.12 python3.12-venv python3.12-distutils

RUN python3.12 -m venv /.venv3.12

RUN python3.11 -m venv /.venv3.11

RUN python3.10 -m venv /.venv3.10

RUN python3.9 -m venv /.venv3.9
