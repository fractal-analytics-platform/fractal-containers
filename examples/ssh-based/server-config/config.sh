#!/bin/bash

# Trigger collection of fractal-tasks-core
fractal task collect fractal-tasks-core --package-extras fractal-tasks

# Download test zarr data
mkdir -p /data/zarrs
cd /data/zarrs/ || exit 1
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
echo "START - change permissions for /data/images and /data/zarrs/"
chmod 777 /data/images/ --recursive
chmod 777 /data/zarrs/ --recursive
echo "END   - change permissions for /data/images and /data/zarrs/"
