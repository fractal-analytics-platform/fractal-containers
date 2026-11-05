#!/bin/bash

service slurmdbd start
service mariadb start
service slurmctld restart

echo
sinfo
echo