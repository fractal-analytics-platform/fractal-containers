FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y software-properties-common 
RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt install -y python3.9 python3.9-distutils python3.9-venv

RUN apt install -y python3.11 python3.11-venv

RUN apt install -y python3.12 python3.12-venv
