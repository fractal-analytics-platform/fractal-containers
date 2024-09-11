#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

NUM_PROJECTS=10
NUM_IMAGES=10

source venv/bin/activate


###############################################################################

LABEL=$(date +%s)
WORKFLOW_JSON_FILE=tmp_${LABEL}.json

SUBMIT_SCRIPT=3_submit_jobs.sh
echo "#!/bin/bash" > "$SUBMIT_SCRIPT"
echo "source venv/bin/activate" >> "$SUBMIT_SCRIPT"
chmod +x "$SUBMIT_SCRIPT"

echo "{ \"image_dir\": \"/invalid\", \"num_images\": $NUM_IMAGES }" > tmp_args_create_ome_zarr_compound.json

for PROJECT_INDEX in $(seq 1 $NUM_PROJECTS); do

    ZARR_DIR=/data/zarrs/output_${LABEL}_${PROJECT_INDEX}
    PROJECT_NAME="Project $LABEL/$PROJECT_INDEX"
    DS_NAME="Dataset $LABEL/$PROJECT_INDEX"
    WORKFLOW_NAME="Workflow $LABEL/$PROJECT_INDEX"

    echo "Now process PROJECT=$PROJECT_NAME"

    # Create project and dataset
    PROJECT_ID=$(fractal --batch project new "$PROJECT_NAME")
    DS_ID=$(fractal --batch project add-dataset "$PROJECT_ID" "$DS_NAME" "$ZARR_DIR")

    # Create or import workflow
    if [[ "$PROJECT_INDEX" == "1" ]]; then
        # Setup and export workflow
        WORKFLOW_ID=$(fractal --batch workflow new "$WORKFLOW_NAME" "$PROJECT_ID")
        fractal --batch workflow add-task "$PROJECT_ID" "$WORKFLOW_ID" --task-name "create_ome_zarr_compound" --args-non-parallel tmp_args_create_ome_zarr_compound.json > /dev/null
        fractal --batch workflow add-task "$PROJECT_ID" "$WORKFLOW_ID" --task-name "illumination_correction" > /dev/null
        fractal --batch workflow export "$PROJECT_ID" "$WORKFLOW_ID" --json-file  "$WORKFLOW_JSON_FILE"
    else
        # Just import workflow, with an up-to-date name
        TMP_OUTPUT=$(fractal --batch workflow import --project-id "$PROJECT_ID" --json-file  "$WORKFLOW_JSON_FILE" --workflow-name "$WORKFLOW_NAME")
        # Strip WorkflowTask IDs from output
        WORKFLOW_ID=$(echo "$TMP_OUTPUT" | cut -f1 -d ' ')
    fi

    SUBMIT_LINE="echo Submitted job with ID=\$(fractal --batch job submit $PROJECT_ID $WORKFLOW_ID $DS_ID)"
    echo "$SUBMIT_LINE"
    echo "$SUBMIT_LINE" >> "$SUBMIT_SCRIPT"
    echo
done
