#!/bin/bash

set -eu
set -o xtrace

# shellcheck disable=SC1091
source ./venv-client/bin/activate

# Create folders and make them 777
# NOTE: Do this before accessing zenodo data, because that operation could hit some rate limit and stall
mkdir -p /data/images
mkdir -p /data/zarrs
chmod 777 /data/images/ --recursive
chmod 777 /data/zarrs/ --recursive

# Download zarr data
# shellcheck disable=SC2164
cd /data/zarrs/
wget --quiet https://zenodo.org/records/10424292/files/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip
unzip -q 20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip
rm -r 20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip __MACOSX

# Download test image data
mkdir /data/images/10.5281_zenodo.8287221
# shellcheck disable=SC2164
cd /data/images/10.5281_zenodo.8287221
wget --quiet https://zenodo.org/api/records/8287221/files-archive
mv files-archive files-archive.zip
unzip -q files-archive.zip
rm files-archive.zip

# Re-apply broad permissions
chmod 777 /data/images/ --recursive
chmod 777 /data/zarrs/ --recursive
