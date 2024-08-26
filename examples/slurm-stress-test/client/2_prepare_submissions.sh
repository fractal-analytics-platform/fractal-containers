#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

NUM_PROJECTS=10
NUM_IMAGES=2


###############################################################################

LABEL="label-$1"

SUBMIT_SCRIPT=3_submit_jobs.sh
echo "#!/bin/bash" > "$SUBMIT_SCRIPT"
chmod +x "$SUBMIT_SCRIPT"

echo "{ \"image_dir\": \"/invalid\", \"num_images\": $NUM_IMAGES }" > tmp_args_create_ome_zarr_compound.json

for PROJECT_INDEX in $(seq 1 $NUM_PROJECTS); do

    ZARR_DIR=/tmp/zarr_dirs/output_${LABEL}_${PROJECT_INDEX}
    PROJECT_NAME="Project $LABEL/$PROJECT_INDEX"
    DS_NAME="Dataset $LABEL/$PROJECT_INDEX"
    WF_NAME="Workflow $LABEL/$PROJECT_INDEX"

    echo "Now process PROJECT=$PROJECT_NAME"

    # Create project, dataset, workflow
    PROJECT_ID=$(fractal --batch project new "$PROJECT_NAME")
    DS_ID=$(fractal --batch project add-dataset "$PROJECT_ID" "$DS_NAME" "$ZARR_DIR")
    WF_ID=$(fractal --batch workflow new "$WF_NAME" "$PROJECT_ID")

    # Add tasks to workflow
    fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "create_ome_zarr_compound" --args-non-parallel tmp_args_create_ome_zarr_compound.json
    fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "illumination_correction"
    # fractal --batch workflow add-task "$PROJECT_ID" "$WF_ID" --task-name "generic_task_parallel" --args-non-parallel args_generic_task_parallel.json

    SUBMIT_LINE="fractal --batch job submit $PROJECT_ID $WF_ID $DS_ID"
    echo "$SUBMIT_LINE"
    echo "$SUBMIT_LINE" >> "$SUBMIT_SCRIPT"
    echo
done
