#!/bin/bash
# Test-only CA and server certificate for the slurmrestd TLS proxy
set -euo pipefail

mkdir -p /etc/slurm/tls
cd /etc/slurm/tls

# Extensions required by Python >= 3.13 strict certificate verification
cat > ca.ext <<EOF
basicConstraints=critical,CA:TRUE
keyUsage=critical,keyCertSign,cRLSign
subjectKeyIdentifier=hash
EOF
cat > server.ext <<EOF
basicConstraints=critical,CA:FALSE
keyUsage=critical,digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer
subjectAltName=DNS:localhost,DNS:slurm,IP:127.0.0.1
EOF

openssl req -new -nodes -newkey rsa:2048 -subj "/CN=fractal-test-ca" -keyout ca.key -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -days 3650 -extfile ca.ext -out ca.pem
openssl req -new -nodes -newkey rsa:2048 -subj "/CN=slurm" -keyout server.key -out server.csr
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -days 3650 -extfile server.ext -out server.pem

rm ca.key ca.csr ca.ext ca.srl server.csr server.ext
chmod 644 ca.pem server.pem
chmod 600 server.key
