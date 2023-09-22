#!/bin/bash

cd 01_cardio_tiny_dataset
cp ../.fractal.env .
./fetch_test_data_from_zenodo.sh
./run_example.sh
