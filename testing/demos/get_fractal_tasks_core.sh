#!/bin/bash

set -o xtrace

# Trigger collection of `fractal-tasks-core`, either from PyPI or from a
# wheel file built locally.

check_exit_code() {
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        echo "Error: $1 (EXIT_CODE=$EXIT_CODE)"
        exit 1
    fi
}

# shellcheck disable=SC1091
source config.env
echo "FRACTAL_TASKS_CORE_V2_RELEASE=$FRACTAL_TASKS_CORE_V2_RELEASE"
echo "FRACTAL_TASKS_CORE_V2_GIT=$FRACTAL_TASKS_CORE_V2_GIT"

export PANDAS_PIN_OPTION="--post-pinned-dependency pandas=2.3.3"

if [ -z "${FRACTAL_TASKS_CORE_V2_RELEASE}" ]; then
    if [ -z "${FRACTAL_TASKS_CORE_V2_GIT}" ]; then
        # Case 1: no release, no git
        fractal task collect fractal-tasks-core --package-extras fractal-tasks
    else


        # Case 2: only git set
        git clone https://github.com/fractal-analytics-platform/fractal-tasks-core.git
        (
            # shellcheck disable=SC2164
            cd fractal-tasks-core
            git checkout "$FRACTAL_TASKS_CORE_V2_GIT"
            check_exit_code "git checkout $FRACTAL_TASKS_CORE_V2_GIT"

            curl -sSL https://install.python-poetry.org | python3 -
            check_exit_code "Poetry installation"

            /root/.local/bin/poetry build

            WHL=$(ls dist/*.whl)
            check_exit_code "ls wheel file"
            ABS_WHL="$(pwd)/$WHL"
            chmod 777 "$ABS_WHL"

            fractal task collect "$ABS_WHL" --package-extras fractal-tasks $PANDAS_PIN_OPTION
        )
    fi
else
    if [ -z "${FRACTAL_TASKS_CORE_V2_GIT}" ]; then
        # Case 3: only release set
        fractal task collect fractal-tasks-core --package-extras fractal-tasks --package-version "$FRACTAL_TASKS_CORE_V2_RELEASE" $PANDAS_PIN_OPTION
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_TASKS_CORE_V2_RELEASE and FRACTAL_TASKS_CORE_V2_GIT."
        exit 1
    fi
fi
