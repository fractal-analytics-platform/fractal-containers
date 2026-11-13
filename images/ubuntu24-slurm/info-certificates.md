# TLS certificates for `slurmrestd` (for information only)

The files in `tls/` are used by the `socat` proxy that serves `slurmrestd` over HTTPS on port `6820`.
They are for testing only, and they are committed on purpose.

- `ca.pem`: test certificate authority (CA). Clients use it to trust the server.
- `server.pem`, `server.key`: server certificate and key, valid for `localhost`, `slurm` and `127.0.0.1`.

They were generated once, valid for 10 years (see commands below if need to replicate). The CA private key is not kept.
The certificates include the extensions required by the strict checks of Python >= 3.13.

If they are regenerated, update also any copy of `ca.pem` used elsewhere (e.g. in the `fractal-server` tests).

From `images/ubuntu24-slurm`:

```console
mkdir -p tls
docker run --rm -v "$PWD/tls:/tls" -w /tls ubuntu:24.04 bash -euc '
apt-get update -qq && apt-get install -y -qq openssl > /dev/null
printf "%s\n" \
  "basicConstraints=critical,CA:TRUE" \
  "keyUsage=critical,keyCertSign,cRLSign" \
  "subjectKeyIdentifier=hash" > ca.ext
printf "%s\n" \
  "basicConstraints=critical,CA:FALSE" \
  "keyUsage=critical,digitalSignature,keyEncipherment" \
  "extendedKeyUsage=serverAuth" \
  "subjectKeyIdentifier=hash" \
  "authorityKeyIdentifier=keyid,issuer" \
  "subjectAltName=DNS:localhost,DNS:slurm,IP:127.0.0.1" > server.ext
openssl req -new -nodes -newkey rsa:2048 -subj "/CN=fractal-test-ca" -keyout ca.key -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -days 3650 -extfile ca.ext -out ca.pem
openssl req -new -nodes -newkey rsa:2048 -subj "/CN=slurm" -keyout server.key -out server.csr
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -days 3650 -extfile server.ext -out server.pem
rm ca.key ca.csr ca.ext ca.srl server.csr server.ext
chmod 644 ca.pem server.pem server.key
'
```

`server.key` is readable here only so that it can be committed and sent to the docker build; the `Dockerfile` sets it to `600`.
