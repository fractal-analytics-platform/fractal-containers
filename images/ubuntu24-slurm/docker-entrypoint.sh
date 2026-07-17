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

# slurmctld
attempt=1
max_seconds=10
service slurmctld start
while [ "$attempt" -le $max_seconds ]; do
  status=$(service slurmctld status 2>&1)
  if [ -z "$status" ]; then
    echo "[W] Empty response from \"slurmctld status\": trying to start slurmctld again..."
    service slurmctld start
  elif service slurmctld status 2>&1 | grep -q "running"; then
    break
  fi
  sleep 1
  attempt=$((attempt + 1))
done
if [ $attempt -ge $max_seconds ]; then
  echo "slurmctld didn't reach running status after $max_seconds seconds" >&2
  exit 1
fi

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
