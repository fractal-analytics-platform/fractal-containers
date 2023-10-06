source config.env
echo "FRACTAL_TASKS_CORE_RELEASE=$FRACTAL_TASKS_CORE_RELEASE"
echo "FRACTAL_TASKS_CORE_GIT=$FRACTAL_TASKS_CORE_GIT"
if [ -z "${FRACTAL_TASKS_CORE_RELEASE}" ]; then
    if [ -z "${FRACTAL_TASKS_CORE_GIT}" ]; then
        # Case 1: no release, no git
        fractal task collect fractal-tasks-core --package-extras fractal-tasks
    else
        # Case 2: only git set
        # TODO: git clone, git checkout, install poetry, poetry build, collect from local wheel file
        echo "Error: FRACTAL_TASKS_CORE_GIT not supported" && exit 1
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
