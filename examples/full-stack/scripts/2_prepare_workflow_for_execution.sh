#!/bin/bash

set -eu

export FRACTAL_USER=admin@example.org
export FRACTAL_PASSWORD=1234
export FRACTAL_SERVER=http://localhost:8000


LABEL="cardiac"

PROJECT_NAME="proj-$LABEL"
DS_NAME="ds-$LABEL"
WF_NAME="Workflow $LABEL"


# Create project
PROJECT_ID=$(fractal --batch project new "$PROJECT_NAME")
echo "PROJECT_ID=$PROJECT_ID created"

# Add input dataset, and add a resource to it
DS_ID=$(fractal --batch project add-dataset "$PROJECT_ID" "$DS_NAME" --project-dir "/data/zarrs/test01" --zarr-subfolder "$LABEL")
echo "DS_IN_ID=$DS_ID created"

# Import workflow
WF_ID=$(fractal --batch workflow import --project-id "$PROJECT_ID" --json-file workflow.json --workflow-name "$WF_NAME")
echo "WF_ID=$WF_ID created"
