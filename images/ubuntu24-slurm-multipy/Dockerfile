FROM ghcr.io/fractal-analytics-platform/ubuntu24-slurm:0.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Install non-standard Python versions
RUN apt install -y python3.11 python3.11-venv
RUN apt install -y python3.13 python3.13-venv

# Create a venv for each Python version
RUN python3.11 -m venv /.venv3.11
RUN python3.12 -m venv /.venv3.12
RUN python3.13 -m venv /.venv3.13
