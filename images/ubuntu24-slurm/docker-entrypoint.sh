#!/bin/bash

# Default node info
export NODE_ADDR=127.0.0.1

NODE="slurmnode1"
SLURMDBD_PORT=6819

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

# checking slurmdbd port
attempt=1
max_seconds=10
while ! timeout 1 bash -c "</dev/tcp/127.0.0.1/$SLURMDBD_PORT" 2>/dev/null; do
  echo "Waiting for port $SLURMDBD_PORT to be ready..."
  sleep 1
  attempt=$((attempt + 1))
  if [ $attempt -gt $max_seconds ]; then
    echo "Port $SLURMDBD_PORT not ready after $max_seconds seconds" >&2
    exit 1
  fi
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

echo
echo "Starting slurmrestd (https://localhost:6820, JWT auth)"
echo

# Skip the namespace isolation steps, not allowed by Docker's default seccomp profile
SLURMRESTD_SECURITY=disable_unshare_sysv,disable_unshare_files SLURM_JWT=daemon \
  runuser -u slurmrestd -- slurmrestd -a rest_auth/jwt -s slurmctld 127.0.0.1:6821 \
  > /var/log/slurm/slurmrestd.log 2>&1 &
socat OPENSSL-LISTEN:6820,reuseaddr,fork,cert=/etc/slurm/tls/server.pem,key=/etc/slurm/tls/server.key,verify=0 \
  TCP:127.0.0.1:6821 > /var/log/slurm/rest-tls-proxy.log 2>&1 &

exec "$@"
