#!/bin/bash

set -e


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


echo "START run_all_demos.sh"

# Due to how fractal-demos scripts are written, we should have a .fractal.env
# file also in 00_user_setup
cp .fractal.env 00_user_setup
cp .fractal.env 01_cardio_tiny_dataset
cp .fractal.env 02_cardio_small

# Copy images from Resources folder
mkdir images
cp -r /home/fractal_share/Resources/images/10.5281_zenodo.8287221 images/
cp -r /home/fractal_share/Resources/images/10.5281_zenodo.7057076 images/

# Pre-populate `zarr_dir` folders for both examples, so that we can make
# them broadly accessible
ZARRDIR01=./01_cardio_tiny_dataset/output_cardiac-tiny
ZARRDIR02=./02_cardio_small/output-cardio-2x2-zenodo-subset
PARAMETERSDIR01=./01_cardio_tiny_dataset/Parameters
PARAMETERSDIR02=./02_cardio_small/Parameters
for THISDIR in "$ZARRDIR01" "$ZARRDIR02" "$PARAMETERSDIR01" "$PARAMETERSDIR02"; do
    mkdir -p "$THISDIR"
    chmod -R 777 "$THISDIR"
done

# Trigger task collection
bash get_fractal_tasks_core.sh

# Add pwd as a project_dir
USER_ID=$(fractal --batch user whoami)
fractal user edit "$USER_ID" --add-project-dir "$(pwd)"

# Wait for task collection to be complete
while [ "$(fractal task list)" == "[]" ]; do
    echo "No task available, wait 10 seconds.";
    sleep 10;
done

# Enter 01_cardio_tiny_dataset folder
cd 01_cardio_tiny_dataset

# Run example 01 and capture exit code
echo "START examples/01 API calls"
TMPFILE="tmp_01_api.txt"
./run_example.sh >> $TMPFILE 2>&1
API_EXITCODE=$?
cat $TMPFILE

# Check exit code
if [ $API_EXITCODE -ne 0 ]; then
    echo "Error: examples/01 API_EXITCODE=$API_EXITCODE"
    exit 1
fi

# Parse temporary file to extract PROJECT_ID and JOB_ID
PROJECT_ID=$(cat $TMPFILE | grep "PROJECT_ID" | cut -d '=' -f 2)
JOB_ID=$(cat $TMPFILE | grep "JOB_ID" | cut -d '=' -f 2)
echo "PROJECT_ID=$PROJECT_ID"
echo "JOB_ID=$JOB_ID"

# Wait for job to be done or failed
wait_for_job "$PROJECT_ID" "$JOB_ID" "examples/01"

# Check job status, once again
fractal job show "$PROJECT_ID" "$JOB_ID"
echo "END examples/01 API calls"

# Start output validation
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

echo "examples/01 API_EXITCODE=$API_EXITCODE"
echo "examples/01 VALIDATION_EXIT_CODE=$VALIDATION_EXIT_CODE"
echo "END examples/01 output validation"
echo ""

cd ..

# Enter 02_cardio_small
cd 02_cardio_small

# Run example 02 and capture exit code

echo "START examples/02 API calls"
TMPFILE="tmp_02_api.txt"

./run_example_on_image_subset.sh >> $TMPFILE 2>&1
API_EXITCODE=$?
cat $TMPFILE

# Check exit code
if [ $API_EXITCODE -ne 0 ]; then
    echo "Error: examples/02 API_EXITCODE=$API_EXITCODE"
    exit 1
fi

# Parse temporary file to extract PROJECT_ID and JOB_ID
PROJECT_ID=$(cat $TMPFILE | grep "PROJECT_ID" | cut -d '=' -f 2)
JOB_ID=$(cat $TMPFILE | grep "JOB_ID" | cut -d '=' -f 2)
echo "PROJECT_ID=$PROJECT_ID"
echo "JOB_ID=$JOB_ID"

# Wait for job to be done or failed
wait_for_job "$PROJECT_ID" "$JOB_ID" "examples/02"

# Check job status, once again
fractal job show "$PROJECT_ID" "$JOB_ID"
echo "END examples/02 API calls"

# Start output validation
echo "START examples/02 output validation"
TMPFILE="tmp_02_validation.txt"
python validate_results.py >> $TMPFILE 2>&1
VALIDATION_EXIT_CODE=$?
cat $TMPFILE

# Check exit code
if [ $VALIDATION_EXIT_CODE -ne 0 ]; then
    echo "Error: examples/02 VALIDATION_EXIT_CODE=$VALIDATION_EXIT_CODE"
    exit 1
fi

echo "examples/02 API_EXITCODE=$API_EXITCODE"
echo "examples/02 VALIDATION_EXIT_CODE=$VALIDATION_EXIT_CODE"
echo "END examples/02 output validation"
echo ""

echo "END run_all_demos.sh"
