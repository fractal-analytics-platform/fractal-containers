#!/bin/bash

# Default node info
export NODE_ADDR=127.0.0.1

NODE="slurmnode1"

echo "$NODE_ADDR   $NODE" >> /etc/hosts

echo
echo "Starting Slurm services (munge, slurmdbd, mariadb, slurmctld, slurmd)"
echo

service munge start
service slurmdbd start
service mariadb start
service slurmctld restart
service slurmd start
slurmd -N $NODE

echo
echo "Starting SSH service"
service ssh start

echo
echo "squeue --version"
squeue --version
echo
echo "sinfo"
sinfo
echo
echo

exec "$@"
