FROM ubuntu:22.04

ARG SLURM_VERSION=23.02.7
ARG SLURM_ROOT=/opt/slurm-${SLURM_VERSION}
ARG SLURM_CONFDIR=${SLURM_ROOT}/etc

RUN apt update -y
RUN apt install -y munge build-essential mariadb-server wget curl

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /run/munge
RUN chmod 777 /run/munge
RUN chmod +t /run/munge

RUN apt install -y slurmd slurm-client slurmctld
RUN apt install -y python3 python3-pip
RUN useradd -m admin -s /usr/bin/bash -d /home/admin && echo "admin:admin" | chpasswd && adduser admin sudo && echo "admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd

RUN mkdir -p /var/log/slurm
RUN mkdir -p /var/spool/slurmctld && chown slurm /var/spool/slurmctld && chmod u+rwx /var/spool/slurmctld
RUN mkdir -p /var/spool/slurmd    && chown slurm /var/spool/slurmd    && chmod u+rwx /var/spool/slurmd

COPY slurm.conf /etc/slurm/
COPY cgroup.conf /etc/slurm/
COPY docker-entrypoint.sh /etc/slurm/

ADD sudoers /etc/sudoers
COPY fractal_tasks_mock-0.0.1-py3-none-any.whl ./
COPY slurm_config.json ./
COPY run_server.sh ./
COPY monitor_threads.sh ./
COPY .fractal_server.env ./
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install "fractal-server[gunicorn,postgres-psycopg-binary]==2.2.0a1"

EXPOSE 6817 6818 8000

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
