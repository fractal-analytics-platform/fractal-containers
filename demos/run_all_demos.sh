#!/bin/bash

cd /home/fractal_share/fractal-demos/examples

cp .fractal.env 00_user_setup

# TASK COLLECTION
fractal task collect fractal-tasks-core --package-version 0.12.0 --package-extras fractal-tasks
while [ "$(fractal task list)" == "[]" ]; do
    echo "No task available, wait 10 seconds.";
    sleep 10;
done
fractal task list

# Run example 01
cd 01_cardio_tiny_dataset
mkdir -p ../images
cp ../.fractal.env .

# FIXME: replace with cp -r /home/fractal_share/resources/...
./fetch_test_data_from_zenodo.sh

LOGFILE="log_01.txt"

echo "RUN EXAMPLE 01 - START" >> $LOGFILE
./run_example.sh >> $LOGFILE 2>&1
API_EXITCODE=$?
cat $LOGFILE
PROJECT_ID=$(cat $LOGFILE | grep PRJ_ID | cut -d ':' -f 2)
JOB_ID=$(tail -n 1 $LOGFILE)
echo "PROJECT_ID: $PROJECT_ID"

while true; do
    STATUS_LINE=$(fractal job show $PROJECT_ID $JOB_ID | grep "status")
    echo $STATUS_LINE
    if [[ "$STATUS_LINE" == *done* || "$STATUS_LINE" == *failed* ]]; then
        break
    fi
    sleep 1
done

# Write status to log
fractal job show $PROJECT_ID $JOB_ID

echo "START RESULTS VALIDATION"
echo
pwd
ls -lh
echo
python validate_results.py >> tmp 2>&1
VALIDATION_EXIT_CODE=$?
echo
cat tmp
echo
echo "END RESULTS VALIDATION"
echo
echo "Validation exit code: $VALIDATION_EXIT_CODE"
echo


cd ..
echo "RUN EXAMPLE 01 - END"

# Run example 02
# ...

echo "ALL GOOD"
