Startup all services with one of these commands
```bash
docker compose up
docker compose up --detach
```


# List of services

* Fractal-server is available on port 8000, see e.g http://localhost:8000/docs/
* Fractal-web is available on port 5173, see http://localhost:5173 (credentials: admin@fractal.xy/1234).
* Fractal-vizarr is available on port 3000, see example file at http://localhost:3000/vizarr/?source=http://localhost:3000/vizarr/data/20200812-CardiomyocyteDifferentiation14-Cycle1_mip.zarr/B/03/0.
* A filebrowser is available on port 8080, see http://localhost:8080. This is especially useful if you want to "download" zarr files to your host machine, or if you want to "upload" new input images.


Note that some _fake_ image-processing tasks (which just mimick the actual ones from `fractal-tasks-core`) are already available. This may change in the future, depending on how we expose this demo folder.


# Steps to run an end-to-end demo:

(note that this is not the only possible demo approach, but it is one that should work)

1. Startup services with `docker compose up`

2. Collect tasks and prepare test workflow (notice that these operations could also be performed from the web client at http://localhost:5173):
```
cd scripts
python -m venv venv
source venv/bin/activate
python -m pip install fractal-client
./1_trigger_fractal_tasks_core_collection.sh
# wait a few minutes, and check whether new tasks appear in http://localhost:5173/v2/tasks.
# when collection is over:
./2_prepare_workflow_for_execution.sh
```

3. Head to http://localhost:5173, select your project and workflow, and submit it.

4. The web client will also link to the image viewer (which will be http://localhost:3000/vizarr/?source=http://localhost:3000/vizarr/data/data/zarrs/cardiac-test/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr/B/03/0).
