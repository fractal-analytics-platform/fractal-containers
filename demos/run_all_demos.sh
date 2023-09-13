#!/bin/bash


# I AM IN /home/fractal-share

git clone https://github.com/fractal-analytics-platform/fractal-demos.git

cd fractal-demos/examples
cp ../../.fractal.env .

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

