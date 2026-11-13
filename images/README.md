# Instructions

To build and run the `*-slurm-*` images, for testing purposes, use this commands:

```console
cd <folder>
docker build . -t <name-image>
docker run --hostname slurm <id-image>
```

## SLURM REST API

`ubuntu24-slurm` also runs `slurmrestd` (API `v0.0.40`, JWT auth) behind HTTPS on port `6820`:

```console
docker run --hostname slurm -p 6820:6820 <id-image>
docker exec <container> scontrol token username=test01   # prints SLURM_JWT=<token>
curl --cacert ubuntu24-slurm/tls/ca.pem -H "X-SLURM-USER-NAME: test01" -H "X-SLURM-USER-TOKEN: <token>" \
  https://localhost:6820/slurm/v0.0.40/ping
```

For testing only, the JWT key is a fixed value (see `ubuntu24-slurm/Dockerfile`), so tokens can also be created without `scontrol`.
The TLS certificates are committed in `ubuntu24-slurm/tls/`, see [`ubuntu24-slurm/info-certificates.md`](ubuntu24-slurm/info-certificates.md).

[`ubuntu24-slurm/tests/test_slurmrestd.sh`](ubuntu24-slurm/tests/test_slurmrestd.sh) shows more examples (submit, list and cancel a job) and checks that the API works:

```console
docker cp ubuntu24-slurm/tests/test_slurmrestd.sh <container>:/tmp/
docker exec <container> bash /tmp/test_slurmrestd.sh
```
