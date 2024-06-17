#!/bin/bash

# Default slurm controller
: "${SLURMCTLD_HOST=$HOSTNAME}"
: "${SLURMCTLD_ADDR=127.0.0.1}"

# Default node info
: "${NODE_HOST=$HOSTNAME}"
: "${NODE_ADDR=127.0.0.1}"
: "${NODE_BASEPORT=6001}"

# Default hardware profile
: "${NODE_HW=CPUs=4}"

NODE_NAMES="nd00001"
NODE_PORTS="6001"

export PATH=$SLURM_ROOT/bin:$PATH
export LD_LIBRARY_PATH=$SLURM_ROOT/lib:$LD_LIBRARY_PATH
export MANPATH=$SLURM_ROOT/man:$MANPATH

NODE_NAME_LIST=$(scontrol show hostnames $NODE_NAMES)

for n in $NODE_NAME_LIST
do
    echo "$NODE_ADDR       $n" >> /etc/hosts
done
service munge start
echo
echo "Starting Slurm services..."
echo

$SLURM_ROOT/sbin/slurmctld
$SLURM_ROOT/sbin/slurmd

echo
sinfo
echo
echo

tail -f /dev/null
