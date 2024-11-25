#!/bin/bash

SSH_HOST="slurm"
SSH_USER="test01"
SSH_PRIVATE_KEY_FILE="/ssh_key_test01.key"

SETTINGS_FILE=./ssh-settings.json
echo "{" > "$SETTINGS_FILE"
echo " \"ssh_host\": \"${SSH_HOST}\"," >> "$SETTINGS_FILE"
echo " \"ssh_username\": \"${SSH_USER}\"," >> "$SETTINGS_FILE"
echo " \"ssh_private_key_path\": \"${SSH_PRIVATE_KEY_FILE}\"," >> "$SETTINGS_FILE"
echo " \"ssh_tasks_dir\": \"/data/remote/tasks/\"," >> "$SETTINGS_FILE"
echo " \"ssh_jobs_dir\": \"/data/remote/jobs/\"" >> "$SETTINGS_FILE"
echo "}" >> "$SETTINGS_FILE"
cat "$SETTINGS_FILE"

# Update user
FRACTAL_USER_ID=$(fractal --batch user whoami)
fractal user edit "$FRACTAL_USER_ID" --new-ssh-settings-json "$SETTINGS_FILE"

# Assuming that group 1 is the ALL
ALL_GROUP_ID=1
if [ $(fractal group get "$ALL_GROUP_ID" | grep name | grep All) != "0" ]; then
    echo "User group with id $ALL_GROUP_ID is not the 'All' group. Exit."
    exit 1
fi
fractal group update "$ALL_GROUP_ID" --new-viewer-paths /data

# Trigger collection of fractal-tasks-core
fractal task collect fractal-tasks-core --package-extras fractal-tasks


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
