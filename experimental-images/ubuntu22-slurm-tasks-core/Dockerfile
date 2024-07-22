FROM ghcr.io/fractal-analytics-platform/ubuntu22-slurm:0.1

# Install system libraries
# required for installing client/tasks from git
RUN apt-get update
RUN apt-get -y install git  
RUN apt-get -y install curl

RUN python3 -m venv fractal-tasks-venv
RUN fractal-tasks-venv/bin/python -m pip install fractal-tasks-core[fractal-tasks]

# Install requirements for output-validation Python script
ADD demos-v1/requirements-validation.txt ./requirements-validation.txt
RUN fractal-tasks-venv/bin/python -m pip install -r requirements-validation.txt
