FROM ubuntu:22.04


ARG DEBIAN_FRONTEND=noninteractive

# !!! Workaround for munge deamon
RUN mkdir /run/munge
RUN chmod 777 /run/munge
RUN chmod +t /run/munge

# Slurm configuration
RUN apt update -y
RUN apt install -y munge slurmd slurm-client slurmctld mariadb-server
RUN apt install -y python3 python3-pip
COPY slurm.conf /etc/slurm/
COPY cgroup.conf /etc/slurm/
COPY docker-entrypoint.sh /etc/slurm/
# !!! Workaround for slurm deamon
RUN mkdir -p /var/log/slurm
RUN mkdir -p /var/spool/slurmctld && chown slurm /var/spool/slurmctld && chmod u+rwx /var/spool/slurmctld
RUN mkdir -p /var/spool/slurmd    && chown slurm /var/spool/slurmd    && chmod u+rwx /var/spool/slurmd

# User configuration
ADD sudoers /etc/sudoers
RUN useradd -m fractal -s /usr/bin/bash -d /home/fractal && echo "fractal:fractal" | chpasswd && adduser fractal sudo && echo "fractal     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd

# Fractal configuration
COPY fractal_tasks_mock-0.0.1-py3-none-any.whl ./
COPY slurm_config.json ./
COPY run_server.sh ./
COPY .fractal_server.env ./
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install "fractal-server[gunicorn,postgres-psycopg-binary]==2.2.0a1"

EXPOSE 6817 6818 8000

ENTRYPOINT ["/etc/slurm/docker-entrypoint.sh"]
