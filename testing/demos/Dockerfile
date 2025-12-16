FROM python:3.11-slim

RUN apt update && apt install -y git curl

# Install requirements for output-validation Python script
RUN python3 -m pip install "zarr<3"

ADD config.env .

COPY demos/get_fractal_client.sh ./get_fractal_client.sh
RUN bash get_fractal_client.sh

COPY demos/validate_results_01.py ./validate_results_01.py
# COPY demos/validate_results_02.py ./validate_results_02.py

ADD config.env .

COPY demos/get_fractal_tasks_core.sh .
ADD demos/run_demos.sh .
