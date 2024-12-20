#!/bin/bash

# Update user
FRACTAL_USER_ID=$(fractal --batch user whoami)
fractal user edit "$FRACTAL_USER_ID" --new-project-dir /home/test01 --new-slurm-user test01

# Download test zarr data
mkdir -p /data/zarrs
cd /data/zarrs/
wget --quiet https://zenodo.org/records/10424292/files/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip
unzip -q 20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip
rm -r 20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip __MACOSX

# Download test image data
mkdir -p /data/images
mkdir /data/images/10.5281_zenodo.8287221
cd /data/images/10.5281_zenodo.8287221
wget --quiet https://zenodo.org/api/records/8287221/files-archive
mv files-archive files-archive.zip
unzip -q files-archive.zip
rm files-archive.zip

# Change permissions
chmod 777 /data/images/ --recursive
chmod 777 /data/zarrs/ --recursive
