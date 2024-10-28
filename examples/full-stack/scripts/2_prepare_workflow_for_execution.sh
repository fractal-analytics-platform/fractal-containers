#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

LABEL="cardiac1"

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

# Import workflow
WF_ID=$(fractal --batch workflow import --project-id "$PROJECT_ID" --json-file workflow.json --workflow-name "$WF_NAME")
echo "WF_ID=$WF_ID created"
