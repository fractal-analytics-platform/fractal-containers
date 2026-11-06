# ubuntu24-slurm-accounting

SLURM image with job accounting enabled (`slurmdbd` + MariaDB), built on top of
`ghcr.io/fractal-analytics-platform/ubuntu24-slurm`.

## Build and run

```console
docker build . -t ubuntu24-slurm-accounting
docker run -d --name slurm-accounting --hostname slurm ubuntu24-slurm-accounting
```

The `--hostname slurm` flag is required, since it is the hostname expected by
`slurm.conf`.

## Test accounting

Open a shell in the container as the `fractal` user:

```console
docker exec -it slurm-accounting su - fractal
```

Submit a job and check that it reaches the queue:

```console
$ sbatch --wrap "sleep 1"
Submitted batch job 1
```

```
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                 1      main     wrap  fractal PD       0:00      1 (None)
```

Once the job is over, check that it was recorded by the accounting database
(replace `1` with the `JOBID` printed by `sbatch`):

```console
$ sacct -j 1
JobID           JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
1                  wrap       main                     1  COMPLETED      0:0
1.batch           batch                                1  COMPLETED      0:0
```

## Clean up

```console
docker rm -f slurm-accounting
```