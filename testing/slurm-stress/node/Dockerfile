FROM rancavil/slurm-node:19.05.5-1


# Relink python3 (from 3.8 to 3.9)
RUN sudo rm -f /usr/bin/python3
RUN sudo ln -s /usr/bin/python3.9 /usr/bin/python3

RUN sudo apt-get update
RUN sudo apt-get -y install python3-pip

COPY slurm.conf /etc/slurm-llnl/

RUN pip3 install --upgrade pip setuptools wheel devtools

RUN useradd --uid 2001 -m test01 -s /usr/bin/bash -d /home/test01 && echo "test01:test01" | chpasswd

# Install fractal-server from PyPI
# FIXME: this should match the version from slurm head container
RUN pip3 install "fractal-server==2.0.6"

ENTRYPOINT ["/etc/slurm-llnl/docker-entrypoint.sh"]
