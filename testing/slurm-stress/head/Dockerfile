FROM rancavil/slurm-master:19.05.5-1

RUN apt-get update

# Relink python3 (from 3.8 to 3.9)
RUN sudo rm -f /usr/bin/python3
RUN sudo ln -s /usr/bin/python3.9 /usr/bin/python3

RUN apt-get -y install python3-pip python3.9-venv python3.9-dev htop
RUN apt-get -y install gcc postgresql postgresql-contrib libpq-dev  # required for building psycopg2

COPY slurm.conf /etc/slurm-llnl/
ADD sudoers /etc/sudoers

COPY slurm_config.json ./
COPY run_server.sh ./
COPY monitor_threads.sh ./
COPY .fractal_server.env ./
COPY fractal_tasks_mock-0.0.1-py3-none-any.whl ./

RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd

RUN pip3 install --upgrade pip setuptools wheel

# Install fractal-server from PyPI
RUN pip3 install "fractal-server[gunicorn,postgres]==2.0.6"

EXPOSE 8000
EXPOSE 50097
ENTRYPOINT ["/etc/slurm-llnl/docker-entrypoint.sh"]
