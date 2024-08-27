#!/bin/bash

rm -r dummy-output
mkdir dummy-output

for INDEX in {1..10}; do
   date
   sbatch single_submit.sh "$INDEX"
done
