FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# Slurm configuration
RUN apt update -y
RUN apt install -y sudo munge slurmd slurm-client slurmctld mariadb-server slurmdbd slurmrestd
RUN apt install -y vim less curl
RUN apt install -y ca-certificates
RUN apt install -y socat
RUN apt install -y python3 python3-pip python3-venv
COPY slurm.conf /etc/slurm/
COPY cgroup.conf /etc/slurm/
COPY slurmdbd.conf /etc/slurm/
RUN chmod 600 /etc/slurm/slurmdbd.conf
# Fixed JWT key and TLS certificates for slurmrestd (see info-certificates.md)
RUN printf '%s' 'fractal-containers-test-only-jwt-key' > /etc/slurm/jwt_hs256.key && chmod 600 /etc/slurm/jwt_hs256.key
COPY tls/ /etc/slurm/tls/
RUN chmod 600 /etc/slurm/tls/server.key

# SSH configuration
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Install apptainer
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:apptainer/ppa
RUN apt update -y
RUN apt install -y apptainer

# User configuration
ADD sudoers /etc/sudoers
RUN useradd -m fractal -s /usr/bin/bash -d /home/fractal && echo "fractal:fractal" | chpasswd && adduser fractal sudo && echo "fractal     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd
# Lets jobs run as `fractal` write into folders created by `test01` (SLURM user != SSH user)
RUN usermod -aG test01 fractal
# slurmrestd refuses to run as root or as SlurmUser
RUN useradd -r -M -s /usr/sbin/nologin slurmrestd
COPY docker-entrypoint.sh /etc/slurm/
EXPOSE 22 6817 6818 6820 8000

# Install pixi
RUN mkdir /pixi
COPY install_pixi.sh /pixi/install_pixi.sh
RUN bash /pixi/install_pixi.sh


ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
