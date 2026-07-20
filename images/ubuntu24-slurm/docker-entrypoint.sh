#!/bin/bash

# Default node info
export NODE_ADDR=127.0.0.1

NODE="slurmnode1"

echo "$NODE_ADDR   $NODE" >> /etc/hosts


echo
echo "Starting SSH service"
echo

service ssh start


echo
echo "Starting Slurm services (munge, slurmdbd, mariadb, slurmctld, slurmd)"
echo

service mariadb start
service munge start
service slurmdbd start

while ! bash -c "</dev/tcp/127.0.0.1/6819" 2>/dev/null; do
  echo "Waiting for port 6819 to be ready..."
  sleep 1
done

service slurmctld start

service slurmd start
slurmd -N $NODE

echo
echo "squeue --version"
squeue --version
echo
echo "sinfo"
sinfo
echo
echo

exec "$@"
