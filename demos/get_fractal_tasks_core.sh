check_exit_code() {
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        echo "Error: EXIT_CODE=$EXIT_CODE"
        exit 1
    fi
}

source config.env
echo "FRACTAL_TASKS_CORE_RELEASE=$FRACTAL_TASKS_CORE_RELEASE"
echo "FRACTAL_TASKS_CORE_GIT=$FRACTAL_TASKS_CORE_GIT"
if [ -z "${FRACTAL_TASKS_CORE_RELEASE}" ]; then
    if [ -z "${FRACTAL_TASKS_CORE_GIT}" ]; then
        # Case 1: no release, no git
        fractal task collect fractal-tasks-core --package-extras fractal-tasks
    else
        # Case 2: only git set
        git clone https://github.com/fractal-analytics-platform/fractal-tasks-core.git
        cd fractal-tasks-core
        git checkout FRACTAL_TASKS_CORE_GIT
        check_exit_code

        curl -sSL https://install.python-poetry.org | python3 -
        which poetry
        check_exit_code

        poetry build
        WHL=`ls dist/*.whl`
        check_exit_code

        if [[ $WHL == /* ]]; then
            ABS_WHL="$WHL"
        else
            ABS_WHL="$(pwd)/$WHL"
        fi

        cd ..
        fractal task collect $ABS_WHL --package-extras fractal-tasks
    fi
else
    if [ -z "${FRACTAL_TASKS_CORE_GIT}" ]; then
        # Case 3: only release set
        fractal task collect fractal-tasks-core --package-extras fractal-tasks --package-version $FRACTAL_TASKS_CORE_RELEASE
    else
        # Case 4: both release and git set
        echo "Error: cannot set both FRACTAL_TASKS_CORE_RELEASE and FRACTAL_TASKS_CORE_GIT."
        exit 1
    fi
fi
