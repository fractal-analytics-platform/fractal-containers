For a test through docker, run as follows (from the `ubuntu24-slurm` folder):

```
$ docker build --no-cache . -t ubuntu24-slurm-rest
[...]

$ docker run -d -p 6820:6820 --hostname slurm ubuntu24-slurm-rest tail -f
ff3ecac1a03c1ac7ff85da619283909503bdb125baca40793cbaba1d4483f170

$ export TOKEN=$(docker exec ff scontrol token username=test01 lifespan=600 | sed 's/^SLURM_JWT=//')

$ export CA=./tls/ca.pem

$ ./tests/test_slurmrestd.sh 
ping
token made from the fixed key, without scontrol
wrong token (slurm 23.11 returns 500)
plain http is refused
python with strict TLS checks (default in python >= 3.13)
submit a job
job 8
list jobs
cancel the job
Command scontrol not available, skip check of 'JobState=CANCELLED'
all good
```


For a direct test from within the container, run the same but with
```
$ export TOKEN=$(scontrol token username=test01 lifespan=600 | sed 's/^SLURM_JWT=//')
$ export CA=/etc/slurm/tls/ca.pem
```
