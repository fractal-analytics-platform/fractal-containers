FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG FRACTAL_VERSION
# Slurm configuration
RUN apt update -y
RUN apt install -y sudo munge slurmd slurm-client slurmctld mariadb-server
RUN apt install -y python3 python3-pip
COPY slurm.conf /etc/slurm/
COPY cgroup.conf /etc/slurm/

# SSH configuration
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# User configuration
ADD sudoers /etc/sudoers
RUN useradd -m fractal -s /usr/bin/bash -d /home/fractal && echo "fractal:fractal" | chpasswd && adduser fractal sudo && echo "fractal     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd

COPY docker-entrypoint.sh /etc/slurm/
EXPOSE 22 6817 6818 8000

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
