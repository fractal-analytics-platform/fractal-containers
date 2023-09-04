# fractal-containers

[![fractal-server](https://img.shields.io/badge/fractal--server-1.3.5a1-blue)](https://github.com/fractal-analytics-platform/fractal-server)
[![fractal-web](https://img.shields.io/badge/fractal--web-acdea0c-blue)](https://github.com/fractal-analytics-platform/fractal-web)
[![docker](https://img.shields.io/badge/deployment-docker-blue)](https://github.com/docker)
[![postgresql](https://img.shields.io/badge/PostgreSQL-FF0000)](https://github.com/postgres/postgres)



`fractal-containers` is a containerized implementation of the
[fractal](https://github.com/fractal-analytics-platform)
analytics platform for data analysis. The goal of this project
is to allow rapid deployment of the components of the
framework.




## Quick start
- To simultaneously launch all the containers of the project
  (see below for an introduction to the architecture) execute
  the command

        $ mkdir -p fractal-data/
        $ docker compose up --build

    or

        $ make run

    - The client service is accessible at the URL
      [http://localhost:5173/](http://localhost:5173).

    - The server service is accessible at the URL
      [http://localhost:8000/](http://localhost:8000).

- To remove the generated containers after usage, execute the
  command

        $ docker compose down

    o

        $ make clean




## Architecture overview
The `fractal` framework uses several services which operate
together to perform complex data analysis tasks, and are
containerized in this project. The directives for the
composition of the containers discussed below are exposed in
the `docker-compose.yml` file in the project root.


### Web client

The web client service allows the user to import datasets and
to schedule workflows for data analysis. Its source code is
available on its [git repository](https://github.com/fractal-analytics-platform/fractal-web), with additional documentation being available [here](X).

Here, the web client is ran on the node.js-based
`fractal-client` container, which clones the git repository,
installs the necessary dependencies, and runs the service. The
relative instructions are detailed in
`client/Dockerfile.client`.

The latter is accessible from the host system at the
[localhost:5173](localhost:5173) address. All operations
performed via its interface generate HTTP requests which are
sent to the server service on its `8000` port (see below).


### Server

The **server** service receives task scheduling requests from
(multiple) client instances and coordinates their execution.
This software is available as a
[package](https://pypi.org/project/fractal-server/) on the PyPI
repository, with its [source
code](https://github.com/fractal-analytics-platform/fractal-server)
being published as a repository on github. Additional
documentation on server functionality is available
[here](https://fractal-analytics-platform.github.io/fractal-server/).

Here, the server is ran on the python-based `fractal-server`
container, which installs the server package and relative
dependencies from PyPI and runs the service. The relative
instructions are detailed in `server/Dockerfile.server`.

When started using the commands mentioned above, the folder
`fractal-data` in the project root directory can be used to
store data from the host system. The container will mount this
folder in its filesystem at `/home/fractal-data/`. Both the
container and the host can freely read and modify data within
this folder. If this folder is deleted on the host system, it
is recommended to re-create it *from the host* before launching
the containers.

For data storage purposes, the server here uses PostgreSQL as a
database service, here handled by a separate `fractal-db`
container which receives instructions from the server via its
`5433` port. The DB container is based on the
`postgres:15.4-alpine` image, and will save data in the
`fractal-db-data/` folder in the root project directory. A
healthcheck is defined to avoid the server crashing after the
DB service restarts at the first activation, with server
startup being conditional on its success.

The server is accessible from the host system at the
[http://localhost.8000](http://localhost.8000) address.


### General notes

- Images are rebuilt (downloads are not performed if not
  necessary, however) each time the `make run` command is
  issued.
- Created containers can be cleaned issuing the `make clean`
  command.
- The generated containers communicate via the default network
  created by `docker compose`. Server and client publish their
  `8000` and `5173` ports for access via `localhost` by the
  host browser.
