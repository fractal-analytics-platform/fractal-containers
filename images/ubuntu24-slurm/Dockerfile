FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# Slurm configuration
RUN apt update -y
RUN apt install -y sudo munge slurmd slurm-client slurmctld mariadb-server slurmdbd
RUN apt install -y vim less curl
RUN apt install -y python3 python3-pip python3-venv
COPY slurm.conf /etc/slurm/
COPY cgroup.conf /etc/slurm/
COPY slurmdbd.conf /etc/slurm/
RUN chmod 600 /etc/slurm/slurmdbd.conf

# SSH configuration
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Install pixi
RUN mkdir /pixi
COPY install_pixi.sh /pixi/install_pixi.sh
RUN bash /pixi/install_pixi.sh

# User configuration
ADD sudoers /etc/sudoers
RUN useradd -m fractal -s /usr/bin/bash -d /home/fractal && echo "fractal:fractal" | chpasswd && adduser fractal sudo && echo "fractal     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd
COPY docker-entrypoint.sh /etc/slurm/
EXPOSE 22 6817 6818 8000

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
