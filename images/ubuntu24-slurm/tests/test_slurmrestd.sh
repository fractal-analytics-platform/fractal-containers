#!/bin/bash
# Some checks for slurmrestd in the ubuntu24-slurm image.
# Run it as root inside the container, see images/README.md

set -e

URL=https://localhost:6820/slurm/v0.0.40
CA=/etc/slurm/tls/ca.pem

# get the token for test01 user
TOKEN=$(scontrol token username=test01 lifespan=600 | sed 's/^SLURM_JWT=//')
export TOKEN
AUTH=(-H "X-SLURM-USER-NAME: test01" -H "X-SLURM-USER-TOKEN: $TOKEN")

# slurmrestd can take a few seconds to start
for i in $(seq 30); do
  curl -s --cacert $CA "${AUTH[@]}" $URL/ping > /dev/null && break
  sleep 1
done

echo "ping"
curl -s --cacert $CA "${AUTH[@]}" $URL/ping | grep -q '"pinged": "UP"'

echo "wrong token (slurm 23.11 returns 500)"
CODE=$(curl -s -o /dev/null -w '%{http_code}' --cacert $CA \
  -H "X-SLURM-USER-NAME: test01" -H "X-SLURM-USER-TOKEN: wrong" $URL/jobs)
test "$CODE" = 500

echo "plain http is refused"
if curl -s http://localhost:6820/slurm/v0.0.40/ping; then
  exit 1
fi

echo "python with strict TLS checks (default in python >= 3.13)"
python3 -c '
import os, ssl, urllib.request
ctx = ssl.create_default_context(cafile="/etc/slurm/tls/ca.pem")
ctx.verify_flags |= ssl.VERIFY_X509_STRICT
headers = {"X-SLURM-USER-NAME": "test01", "X-SLURM-USER-TOKEN": os.environ["TOKEN"]}
req = urllib.request.Request("https://localhost:6820/slurm/v0.0.40/ping", headers=headers)
urllib.request.urlopen(req, context=ctx)
'

echo "submit a job"
JOB_ID=$(curl -s --cacert $CA "${AUTH[@]}" -H "Content-Type: application/json" -X POST $URL/job/submit \
  -d '{"script": "#!/bin/bash\nsleep 60", "job": {"current_working_directory": "/tmp", "environment": ["PATH=/bin:/usr/bin"]}}' \
  | python3 -c 'import json, sys; print(json.load(sys.stdin)["job_id"])')
echo "job $JOB_ID"

echo "list jobs"
curl -s --cacert $CA "${AUTH[@]}" $URL/jobs | grep -q "\"job_id\": $JOB_ID,"

echo "cancel the job"
curl -s --cacert $CA "${AUTH[@]}" -X DELETE $URL/job/$JOB_ID > /dev/null
sleep 2
scontrol show job $JOB_ID | grep -q JobState=CANCELLED

echo "all good"
