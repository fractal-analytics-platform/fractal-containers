#!/bin/bash

# Default node info
export NODE_ADDR=127.0.0.1

NODE="slurmnode1"

echo "$NODE_ADDR   $NODE" >> /etc/hosts

echo
echo "Starting Slurm services..."
echo

service munge start
service slurmdbd start
service mariadb start
service slurmctld start
slurmd -N $NODE
service ssh start

echo
sinfo
echo
echo

exec "$@"
