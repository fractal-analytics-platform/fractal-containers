#!/bin/bash

set -eu

export FRACTAL_USER=admin@example.org
export FRACTAL_PASSWORD=1234
export FRACTAL_SERVER=http://localhost:8000

fractal task collect fractal-tasks-core --package-extras fractal-tasks
