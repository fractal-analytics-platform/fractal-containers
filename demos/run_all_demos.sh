#!/bin/bash


cp -v .fractal.env /home/fractal-share/
cd /home/fractal-share
pwd

git clone https://github.com/fractal-analytics-platform/fractal-demos.git

cd fractal-demos/examples
pwd
cp -v ../../.fractal.env .

# Trigger task collection
fractal task collect fractal-tasks-core --package-version 0.11.0 --package-extras fractal-tasks

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
cd ..
echo "RUN EXAMPLE 01 - END"

# Run example 02
# ...

echo "ALL GOOD"

