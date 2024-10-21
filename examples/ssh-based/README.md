This example includes a full-fledged Fractal deployment, useful for demo's and onboarding sessions.

> ⚠️⚠️⚠️ WARNING: This example is not suitable for production use! ⚠️⚠️⚠️
>
> Main reasons:
> 1. This example includes a few assumptions/workarounds (mostly related to data access) that are meant to make a demo session as smooth as possible.
> 2. The persistence of Docker-volume data across container may be counterintuitive, and we should better document how to clean them up (e.g. as in `docker compose down --volumes`).
> 3. The SLURM cluster is created with limited resources, so that the demo can run on small machines as well, and this is currently not configurable.


# List of Fractal services in this example

* The `fractal-server` backend, available on port 8000 (e.g <http://localhost:8000/docs>).
* The `fractal-web` web client, available on port 5173 (see <http://localhost:5173>, with credentials: `admin@fractal.xy`/`1234`).
* The `fractal-vizarr-viewer` service to view OME-Zarrs in the broweser, available on port 3000 (see an example OME-Zarr at <http://localhost:3000/vizarr/?source=http://localhost:3000/vizarr/data/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr/B/03/0>).
* A `filebrowser` service, available on port 8080, see <http://localhost:8080>. This is especially useful if you want to "download" zarr files to your host machine, or if you want to "upload" new input images.

Note that some _fake_ image-processing tasks (which just mimick the actual ones from `fractal-tasks-core`) are already available. This may change in the future, depending on how we expose this demo folder.

# Steps to run an end-to-end demo

(note that this is not the only possible demo approach, but it is one that should work)

1. Clone the repository and browse to the current folder

```bash
git clone https://github.com/fractal-analytics-platform/fractal-containers.git
cd fractal-containers/examples/full-stack
```

2. Startup services with `docker compose up` (this can take a while, e.g. a couple minutes with a poor network connection).

3. Collect `fractal-tasks-core` tasks with `fractal-task` extra. This can be either done from the webclient (at <http://localhost:5173/v2/tasks>, by setting Package to `fractal-tasks-core` and Package Extras to `fractal-tasks`) or from the command line (see below). In both cases, it may take a few minutes and it will use a sizeable amount of disk space (e.g. 5 GB), mostly due to installing `pytorch` in a Python virtual environment.

4. The command-line version of point 3 is e.g. as follows

```
cd scripts
python -m venv venv
source venv/bin/activate
python -m pip install fractal-client
./1_trigger_fractal_tasks_core_collection.sh
# wait a few minutes, and check whether new tasks appear in http://localhost:5173/v2/tasks.
```

5. After task collection is over (that is, you see the new tasks in <http://localhost:5173/v2/tasks>), prepare a new project, dataset and workflow. The command-line version of this operation is as follows:

```
cd scripts
source venv/bin/activate
./2_prepare_workflow_for_execution.sh
```

6. Head to <http://localhost:5173>, select your project and workflow, and submit it via the "Run workflow" button.

7. Wait for the job to end (e.g. by monitoring <http://localhost:5173/v2/jobs>).

8. After the job is over, the dataset page in the webclient will also display a link to the image viewer (which will be <http://localhost:3000/vizarr/?source=http://localhost:3000/vizarr/data/data/zarrs/cardiac-test/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr/B/03/0>). By opening this link, you will view the generated OME-Zarr in your browser.

9. To make accessible the files uploaded/created in the `/data` dir, we add a service called `monitord` into the `fractal-filebrowser` container which uses `inotifywait` tool to check when a new file or dir is created into the `/data` folder and modify its permission from 0644 to 0666.
