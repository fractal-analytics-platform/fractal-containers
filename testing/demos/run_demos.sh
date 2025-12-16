#!/bin/bash

set -eu

wait_for_job() {
    THIS_PROJECT_ID=$1
    THIS_JOB_ID=$2
    DESCRIPTION=$3
    while true; do
        STATUS_LINE=$(fractal job show "$THIS_PROJECT_ID" "$THIS_JOB_ID" | grep "status")
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
            echo "Error: $DESCRIPTION (EXIT_CODE=$EXIT_CODE)"
            exit 1
        fi
        echo "$DESCRIPTION $STATUS_LINE"
        if [[ "$STATUS_LINE" == *done* || "$STATUS_LINE" == *failed* ]]; then
            break
        fi
        sleep 4
    done
}


export FRACTAL_SERVER=http://fractal-server:8000
export FRACTAL_USER=admin@example.org
export FRACTAL_PASSWORD=1234
fractal user whoami


echo "START run_all_demos.sh"

# Create `zarr_dir` folders in advance, so that we can make them 777
mkdir -p /home/fractal_share/zarrs/example-01
chmod -R 777 /home/fractal_share/zarrs/example-01
mkdir -p /home/fractal_share/zarrs/example-02
chmod -R 777 /home/fractal_share/zarrs/example-02
mkdir -p /home/fractal_share/zarrs/.fractal_cache/
chmod -R 777 /home/fractal_share/zarrs/.fractal_cache/


# Trigger task collection
bash get_fractal_tasks_core.sh

# Wait for task collection to be complete
while [ "$(fractal task list)" == "[]" ]; do
    echo "No task available, wait 10 seconds.";
    sleep 10;
done

# EXAMPLE 01

echo "Now crete project"
PROJECT_ID=$(fractal --batch project new "project-01")
echo "PROJECT_ID=$PROJECT_ID"

# Add input dataset, and add a resource to it
echo "Now create dataset"
DATASET_ID=$(
    fractal --batch project add-dataset \
        "$PROJECT_ID" "dataset-01" \
        --project-dir "/home/fractal_share/zarrs" --zarr-subfolder "example-01"
    )
echo "DATASET_ID=$DATASET_ID"

echo "Now import workflow"
WORKFLOW_ID=$(
    fractal --batch workflow import \
    --project-id "$PROJECT_ID" \
    --json-file /home/fractal_share/Resources/workflow01.json | cut -d " " -f1
)
echo "WORKFLOW_ID=$WORKFLOW_ID"

echo "Now submit job"
JOB_ID=$(fractal --batch job submit "$PROJECT_ID" "$WORKFLOW_ID" "$DATASET_ID")
echo "JOB_ID=$JOB_ID"

# Wait for job to be done or failed
echo "Now wait for job completion"
wait_for_job "$PROJECT_ID" "$JOB_ID" "examples/01"

# Check job status, once again
fractal job show "$PROJECT_ID" "$JOB_ID"

echo "START examples/01 output validation"
TMPFILE="tmp_01_validation.txt"
python validate_results.py >> $TMPFILE 2>&1
VALIDATION_EXIT_CODE=$?
cat $TMPFILE

# Check exit code
if [ $VALIDATION_EXIT_CODE -ne 0 ]; then
    echo "Error: examples/01 VALIDATION_EXIT_CODE=$VALIDATION_EXIT_CODE"
    exit 1
fi

echo "END examples/01 output validation"


echo "END run_all_demos.sh"
