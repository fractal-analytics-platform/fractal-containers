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
docker cp <container>:/etc/slurm/tls/ca.pem .
curl --cacert ca.pem -H "X-SLURM-USER-NAME: test01" -H "X-SLURM-USER-TOKEN: <token>" \
  https://localhost:6820/slurm/v0.0.40/ping
```

The JWT key and TLS certificates are generated at build time and are for testing only.
