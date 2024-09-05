#!/bin/bash

# Collect tasks
fractal task collect /fractal_tasks_mock-0.0.1-py3-none-any.whl

# Update user
FRACTAL_USER_ID=$(fractal --batch user whoami )
fractal user edit "$FRACTAL_USER_ID" --new-cache-dir /home/test01 --new-slurm-user test01


# Download test zarr data
mkdir -p /data/zarrs
cd /data/zarrs/
wget https://zenodo.org/records/10424292/files/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip
unzip 20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip -q
rm -r 20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr.zip __MACOSX

# Download test image data
mkdir -p /data/images
mkdir /data/images/10.5281_zenodo.8287221
cd /data/images/10.5281_zenodo.8287221
wget https://zenodo.org/api/records/8287221/files-archive
mv files-archive files-archive.zip
unzip files-archive.zip -q
rm files-archive.zip

# Change permissions
chmod 777 /data/images/ --recursive
chmod 777 /data/zarrs/ --recursive
