This example includes a full-fledged Fractal deployment, useful for demo's and onboarding sessions.

> ⚠️⚠️⚠️ WARNING: This example is not suitable for production use! ⚠️⚠️⚠️
>
> Main reasons:
> 1. This example includes some assumptions/workarounds (mostly related to data access) that are meant to make a demo session as smooth as possible. We don't provide any documentation on how to access data outside of the Fractal containers at this point.
> 2. The persistence of Docker-volume data across container may be counterintuitive, and we should better document how to clean them up (e.g. as in `docker compose down --volumes`).
> 3. The SLURM cluster is created with limited resources, so that the demo can run on small machines as well. You would have to change the configuration of the `slurm` service in the `docker-compose.yml` file to adjust that.


# List of Fractal services in this example

* The `fractal-web` web client, available on port 5173 (see http://localhost:5173, and login with credentials `admin@fractal.xy`/`1234`).
* The `fractal-server` backend, available on port 8000 (see e.g http://localhost:8000/docs).
* The `fractal-data` service that serves OME-Zarr files and loads the vizarr viewer to view them in the browser, available on port 3000 (see an example OME-Zarr at http://localhost:3000/data/vizarr/?source=http://localhost:3000/data/files/data/zarrs/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr/B/03/0).
* A `filebrowser` service, available on port 8080, see http://localhost:8080. This is especially useful if you want to "download" zarr files to your host machine, or if you want to "upload" new input images.

Additional containers being run:
* The `slurm` container that runs `fractal-server` also runs a tiny SLURM cluster with access to the same data as the web viewer in the containers.
* The `fractal-db` container runs a postgres database on port 5433 that is used by `fractal-server`.

# Steps to run an end-to-end demo

1. Clone the repository and browse to the current folder

```bash
git clone https://github.com/fractal-analytics-platform/fractal-containers.git
cd fractal-containers/examples/full-stack
```

2. Startup services with `docker compose up`. This can take a while, e.g. a couple minutes with a poor network connection. Verify that all is OK e.g. by browsing to http://localhost:5173 and logging in with default credentials (email `admin@fractal.xy` and password `1234`).

3. Collect the `fractal-tasks-core` tasks pacakge with the `fractal-task` extra. This can be done from the web client or the command line. In both cases, it may take a few minutes and it will use a sizeable amount of disk space (e.g. 5 GB), mostly due to installing `pytorch` in a Python virtual environment.
    * Collecting tasks can be done from the webclient at http://localhost:5173/v2/tasks/management by setting "Package" to `fractal-tasks-core` and "Package Extras" to `fractal-tasks`.
    * The command-line version of point 3 is e.g. as follows
```
cd scripts
python3.12 -m venv venv
source venv/bin/activate
python3.12 -m pip install fractal-client
./1_trigger_fractal_tasks_core_collection.sh
# wait a few minutes, and check whether new tasks appear in http://localhost:5173/v2/tasks.
```

4. After task collection is complete (that is, when you see the new tasks in http://localhost:5173/v2/tasks), prepare a new project, dataset and workflow. You can e.g. use a pre-made script to, as follows:
```
cd scripts
source venv/bin/activate
./2_prepare_workflow_for_execution.sh
```

5. Head to http://localhost:5173, select your project and workflow, and submit it via the "Run workflow" button.

6. Wait for the job to end (e.g. by monitoring http://localhost:5173/v2/jobs).

7. After the job is over, the dataset page in the webclient will also display a link to the image viewer (which will be http://localhost:3000/data/vizarr/?source=http://localhost:3000/data/files/data/zarrs/cardiac/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr/B/03/0). By opening this link, you will view the generated OME-Zarr in your browser.

# FAQs

1. How do I reset the content of the volumes (e.g. delete the database, any files you uploaded etc):

```
docker compose down --volumes
```

2. How do I connect to the docker containers on the terminal, e.g. for data access? Connect to the slurm container the following way (because the slurm container has full data access):

```
docker exec -it slurm bash
```

3. How do I force containers to be rebuilt after changing the docker-compose configuration?

```
docker compose up --build 
```

4. How do I avoid issues with cached docker images?
```
docker compose build --no-cache
```

5. I'm running this on a Mac with Apple Silicon, using the x86 containers. When using tasks with polars (e.g. the projection task in the example), I get a `Missing required CPU features.` warning and then the task crashes. How do I fix that?

This is related to polars running via rosetta. The default polars doesn't handle this well. But you can install polars-lts-cpu (e.g. version 1.30.0) in the package by adding this as a pinned package during task collection. After that, your task should run again. See [this issue for details](https://github.com/fractal-analytics-platform/fractal-server/issues/2584#issuecomment-2916540203).
