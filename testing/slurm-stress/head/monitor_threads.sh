#!/bin/bash


for DUMMY_INDEX in {1..1000}; do
    DATE=$(date)
    NUM_THREADS=$(ps -eo nlwp | tail -n +2 | awk '{ num_threads += $1 } END { print num_threads }')
    echo "[$DATE] Active threads: $NUM_THREADS"
    sleep 1
done
