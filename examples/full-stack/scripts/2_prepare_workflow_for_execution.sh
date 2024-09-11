#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

LABEL="cardiac-test"

PROJECT_NAME="proj-$LABEL"
DS_NAME="ds-$LABEL"
WF_NAME="Workflow $LABEL"
ZARR_DIR=/data/zarrs/${LABEL}


# Set cache path to the local directory, remove it if it exists
FRACTAL_CACHE_PATH=$(pwd)/".cache"
export FRACTAL_CACHE_PATH="$FRACTAL_CACHE_PATH"
if [ -d "$FRACTAL_CACHE_PATH" ]; then
    rm -rv "$FRACTAL_CACHE_PATH"  2> /dev/null
fi


# Create project
PROJECT_ID=$(fractal --batch project new "$PROJECT_NAME")
echo "PROJECT_ID=$PROJECT_ID created"

# Add input dataset, and add a resource to it
DS_ID=$(fractal --batch project add-dataset "$PROJECT_ID" "$DS_NAME" "$ZARR_DIR")
echo "DS_IN_ID=$DS_ID created"

# Create workflow
WF_ID=$(fractal --batch workflow new "$WF_NAME" "$PROJECT_ID")
echo "WF_ID=$WF_ID created"

# Add tasks to workflow
fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "Convert Cellvoyager to OME-Zarr" --args-non-parallel args_cellvoyager_to_ome_zarr_init.json --meta-non-parallel task_meta.json --meta-parallel task_meta.json
fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "Project Image (HCS Plate)" --args-non-parallel args_copy_ome_zarr.json --meta-non-parallel task_meta.json --meta-parallel task_meta.json
