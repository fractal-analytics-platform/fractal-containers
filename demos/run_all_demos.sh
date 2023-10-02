#!/bin/bash

# Wait for the end of task collection
while [ "$(fractal task list)" == "[]" ]; do
    echo "No task available, wait 10 seconds.";
    sleep 10;
done
fractal task list

# Run example 01
echo "RUN EXAMPLE 01 - START"
cd 01_cardio_tiny_dataset
mkdir -p ../images
cp ../.fractal.env .
./fetch_test_data_from_zenodo.sh

./run_example.sh

# FIXME: run_example.sh writes a lot of lines, the last one being the job ID. This must be extracted

# FIXME: Given the job ID, we need to wait until the job is complete/failed.

# FIXME: we need to get the exit code of run_example.sh, and to log it.

# FIXME: run `python3 check_results.py` and log its ouput and exit code


cd ..
echo "RUN EXAMPLE 01 - END"

# Run example 02
# ...

echo "ALL GOOD"
