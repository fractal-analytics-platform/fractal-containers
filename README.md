# fractal-containers

[![fractal-server](https://img.shields.io/badge/fractal--server-1.3.5a1-blue)](https://pypi.org/project/fractal-server/1.3.5a1/)
[![fractal-web](https://img.shields.io/badge/fractal--web-0.5.4-blue)](https://github.com/fractal-analytics-platform/fractal-web/releases/tag/0.5.4)
[![docker](https://img.shields.io/badge/deployment-docker-blue)](https://github.com/docker)
[![postgresql](https://img.shields.io/badge/PostgreSQL-FF0000)](https://github.com/postgres/postgres)


`fractal-containers` is a containerized implementation of the
[Fractal](https://fractal-analytics-platform.github.io) analytics platform for
image analysis. The goal of this project is to allow rapid local deployment of
the components of the framework, especially suitable for demonstration
purposes.


## Quick start

The following instructions will get you from starting the containers to running
an actual image-analysis workflow.

1. From the current directory, run `make run` (or this list of commands: `mkdir -p fractal-share/tasks fractal-share/data; docker compose up --build`). This will launch all the containers, so that:
    * The web-client service is accessible at http://localhost:5173.
    * The server service is accessible at port 8000, see e.g. http://localhost:8000/docs.
2. If you plan to execute some analysis workflow, add some input data in the `fractal-share/data` folder. This repository already includes some testing data which can be used (taken from https://zenodo.org/record/8287221), and you can copy them through `cp -r resources/images fractal-share/data/`.
3. At http://localhost:5173/tasks, start collection of `fractal-tasks-core` package with `fractal-tasks` extra. **WARNING**: this operation runs in background for a while (e.g. 2/3 minutes), and it creates a large subfolder in `fractal-share/tasks` (e.g. ~6G).
4. At http://localhost:5173/projects, create a new project.
5. Within the new-project page, create two dataset:
    * One with name `input`, type `image` and resource path `/home/fractal-share/data/images`.
    * One with name `output`, type `zarr` and resource path `/home/fractal-share/data/output`.
6. Import the workflow JSON file (available in `./resources/workflow.json`) into the project.
7. Open the workflow and run it.


> **NOTE**: because of [a kwown issue in
> `fractal-tasks-core`](https://github.com/fractal-analytics-platform/fractal-tasks-core/issues/508),
> the instructions above will fail when using version 0.10.1.
  

To remove the generated containers after usage, execute one of these commands
```
docker compose down
make clean
```


## Overview

The Fractal framework uses several services which operate together to run
complex image analysis workflows, and are containerized in this repository. The
directives for the composition of the containers discussed below are exposed in
the `docker-compose.yml` file in the project root.

### Web client

The web client service allows the user to import datasets and to schedule
workflows for data analysis. Its source code is available on the [fractal-web
GitHub repository](https://github.com/fractal-analytics-platform/fractal-web).

Here, the web client is ran on the node.js-based `fractal-client` container,
which fetches the source code (for a given version of `fractal-web`), installs
the necessary dependencies, and runs the service. The relative instructions are
detailed in `client/Dockerfile.client`.

The latter is accessible from the host system at the
[localhost:5173](localhost:5173) address. All operations
performed via its interface generate HTTP requests which are
sent to the server service on its `8000` port (see below).

### Server

`fractal-server` is a Python backend for installing image-analysis packages,
interacting with the database, and executing computational workflows. Its
source code is available on [fractal-server GitHub
repository](https://fractal-analytics-platform.github.io/fractal-server), and
the package is [available on PyPI](https://pypi.org/project/fractal-server).
Additional documentation on fractal-server is available
[here](https://fractal-analytics-platform.github.io/fractal-server/).

Here, the server is run within the python-based `fractal-server` container,
which installs the server package and relative dependencies from PyPI and runs
the service. The relative instructions are detailed in
`server/Dockerfile.server`. The server is accessible from the host system at
the http://localhost:8000 address.

### Database

For data storage purposes, the server here uses PostgreSQL as a database
service, which is handled by a separate `fractal-db` container which receives
instructions from the server on its `5433` port. This container is based on
the `postgres:15.4-alpine` image, and will save data in the `fractal-db-data/`
folder in the root project directory. A healthcheck is defined to avoid the
server crashing after the database service restarts at the first activation,
with server startup being conditional on its success.


### `fractal-share` volume

The folder `fractal-share` (which is created in the project root directory
through `make run`, or with the commands listed in point 1 above) is accessible
in read&write mode both fom the current user of the host machine and from
within the fractal-server container. The container will mount this folder in
its filesystem at `/home/fractal-share/`. A `fractal-share/data` subfolder is
the right place to host input data (e.g. some raw images) and to write output
data so that they can be viewed from the host machine.  For instance the output
of the quick-start instructions above can be visualized in
[napari](https://napari.org) through
```
napari --plugin napari-ome-zarr fractal-share/data/output/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr/B/03/0/
```

If the `fractal-share` folder is deleted on the host system, it is recommended
to re-create it *from the host* before launching the containers (so that its
permissions are set correctly).


## Advanced features

What is described above is the "vanilla" version of `fractal-containers`. More
advanced features (e.g. integration of a containerized SLURM cluster) will be
available in the `advanced` subfolder.
