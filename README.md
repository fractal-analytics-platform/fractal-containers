# fractal-containers

<p align="center">
  <img src="https://raw.githubusercontent.com/fractal-analytics-platform/fractal-logos/refs/heads/main/projects/fractal_containers.png" alt="Fractal containers" width="400">
</p>

This repository contains several resources to configure/execute [Fractal](https://fractal-analytics-platform.github.io) services in a containerized environment.
This currently serves three scopes:
1. This repo provides examples for how to run Fractal that are useful for demos and testing. Specifically, the `examples/full-stack` folder contains the core *Getting started with Fractal* example.
2. The `images` folder and the related `publish_*.yml` GitHub Action workflows are used to publish a set of relevant images (see https://github.com/orgs/fractal-analytics-platform/packages?repo_name=fractal-containers).
3. The `testing` folder defines a docker-compose project that regularly runs as [a GitHub action](https://github.com/fractal-analytics-platform/fractal-containers/actions/workflows/test.yml). This is an end-to-end test which also installs [fractal-tasks-core](https://github.com/fractal-analytics-platform/fractal-tasks-core) into Fractal and then runs image-processing workflows 01 and 02 from [fractal-demos](https://github.com/fractal-analytics-platform/fractal-demos).


> ⚠️ The current form of this repository is only used for testing and demos. This may change in the future, but you are not advised to use these containers/images for production instances. ⚠️
