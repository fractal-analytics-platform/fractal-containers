#!/bin/bash

set -e

# Set cache path to the local directory, remove it if it exists
FRACTAL_CACHE_PATH=$(pwd)/".cache"
export FRACTAL_CACHE_PATH="$FRACTAL_CACHE_PATH"
if [ -d "$FRACTAL_CACHE_PATH" ]; then
    rm -rv "$FRACTAL_CACHE_PATH"  2> /dev/null
fi

SUBMIT_SCRIPT=2_submit_jobs.sh
echo "#!/bin/bash"> "$SUBMIT_SCRIPT"
chmod +x "$SUBMIT_SCRIPT"
BASE_LABEL=$(date +%s)

for INDEX in {1..10}; do

    LABEL="${BASE_LABEL}-${INDEX}"
    PROJECT_NAME="proj-$LABEL"
    DS_NAME="ds-$LABEL"
    WF_NAME="wf-$LABEL"
    ZARR_DIR=/data/zarrs/${LABEL}
    WF_JSON_FILE=workflow.json

    # Create project and dataset
    PROJECT_ID=$(fractal --batch project new "$PROJECT_NAME")
    echo "PROJECT_ID=$PROJECT_ID created"
    DS_ID=$(fractal --batch project add-dataset "$PROJECT_ID" "$DS_NAME" --zarr-dir "$ZARR_DIR")
    echo "DS_IN_ID=$DS_ID created"
    # Import workflow
    OUT=$(fractal --batch workflow import --project-id "$PROJECT_ID" --json-file "$WF_JSON_FILE" --workflow-name "$WF_NAME")
    WF_ID=$(echo "$OUT" | cut -d ' ' -f1)
    echo "WF_ID=$WF_ID imported"

    # Prepare submission line
    SUBMIT_LINE="echo Submitted job with ID=\$(fractal --batch job submit $PROJECT_ID $WF_ID $DS_ID)"
    echo "$SUBMIT_LINE"
    echo "$SUBMIT_LINE" >> "$SUBMIT_SCRIPT"
    echo
done

# Create workflow from scratch
# WF_ID=$(fractal --batch workflow new "$WF_NAME" "$PROJECT_ID")
# echo "WF_ID=$WF_ID created"
# fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "Convert Cellvoyager to OME-Zarr" --args-non-parallel args_cellvoyager_to_ome_zarr_init.json --meta-non-parallel task_meta.json --meta-parallel task_meta.json
# fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "Project Image (HCS Plate)" --args-non-parallel args_copy_ome_zarr.json --meta-non-parallel task_meta.json --meta-parallel task_meta.json
