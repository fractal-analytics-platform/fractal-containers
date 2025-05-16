FROM ghcr.io/fractal-analytics-platform/ubuntu24-slurm:0.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Create a venv for each Python version
RUN python3.11 -m venv /.venv3.11
RUN python3.12 -m venv /.venv3.12
