#!/bin/bash

# Default node info
export NODE_ADDR=127.0.0.1

NODE="slurmnode1"

echo "$NODE_ADDR   $NODE" >> /etc/hosts

echo
echo "Starting Slurm services..."
echo

service ssh start
service munge start
service slurmdbd start
service mariadb start
service slurmctld restart
service slurmd start
slurmd -N $NODE

echo
squeue --version
echo
sinfo
echo
echo

exec "$@"
