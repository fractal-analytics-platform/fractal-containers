#!/bin/bash
# Install apptainer from source, following
# https://github.com/apptainer/apptainer/blob/main/INSTALL.md

set -eu

export APPTAINER_VERSION=v1.5.5
export GOVERSION=1.26.10
export OS=linux
ARCH=$(dpkg --print-architecture)
export ARCH

# System dependencies
apt-get update
apt-get install -y \
    build-essential \
    libseccomp-dev \
    libtalloc-dev \
    libattr1-dev \
    libprotobuf-c-dev \
    uidmap \
    fakeroot \
    cryptsetup \
    tzdata \
    dh-apparmor \
    curl wget git

# libsubid support (only available on Ubuntu Noble or newer)
if apt-cache show libsubid-dev > /dev/null 2>&1; then
    apt-get install -y libsubid-dev
fi

# Prerequisites for the FUSE-based packages
apt-get install -y autoconf automake libtool pkg-config libfuse3-dev \
    libarchive-dev zlib1g-dev liblzo2-dev liblz4-dev liblzma-dev libzstd-dev

# Install Go
wget -O /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz \
    https://dl.google.com/go/go${GOVERSION}.${OS}-${ARCH}.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz
rm /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Clone apptainer
git clone https://github.com/apptainer/apptainer.git /tmp/apptainer
cd /tmp/apptainer
git checkout "$APPTAINER_VERSION"

# Download and compile FUSE-based dependencies
./scripts/download-dependencies
./scripts/compile-dependencies

# Configure, build and install apptainer.
# Note: the setuid installation is needed to run apptainer inside a docker
# container, since unprivileged user namespaces are not available there.
./mconfig --with-suid
cd "$(/bin/pwd)/builddir"
make
make install

# Install FUSE-based dependencies (this must run from the top of the source
# tree, after apptainer is installed, since it reads builddir/Makefile and
# copies binaries into apptainer's libexec directory)
cd /tmp/apptainer
./scripts/install-dependencies

# Clean up
cd /
rm -rf /tmp/apptainer /usr/local/go "$HOME/go" "$HOME/.cache/go-build"

apptainer --version
