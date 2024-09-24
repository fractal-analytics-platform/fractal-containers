FROM python:3.11-slim

# Install system libraries
RUN apt update && apt install -y git curl

# Install requirements for output-validation Python script
ADD demos-v2/requirements-validation.txt ./requirements-validation.txt
RUN python3 -m pip install -r requirements-validation.txt

ADD config.env .

COPY demos-v1/get_fractal_client.sh .
RUN bash get_fractal_client.sh

COPY demos-v1/get_fractal_demos.sh .
RUN bash get_fractal_demos.sh

ADD config.env ./fractal-demos-v1/examples/config.env
COPY demos-v1/get_fractal_tasks_core.sh ./fractal-demos-v1/examples/get_fractal_tasks_core.sh
ADD demos-v1/fractal.env ./fractal-demos-v1/examples/.fractal.env
ADD demos-v1/run_demos.sh ./fractal-demos-v1/examples/run_demos.sh
