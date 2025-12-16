FROM python:3.11-slim

RUN apt update
RUN apt install -y unzip wget

ARG FRACTAL_CLIENT_VERSION
RUN python3 -m venv venv-client
RUN ./venv-client/bin/python -m pip install fractal-client==${FRACTAL_CLIENT_VERSION}

ENV FRACTAL_SERVER=http://slurm:8000
ENV FRACTAL_USER=admin@example.org
ENV FRACTAL_PASSWORD=1234

COPY config.sh ./

CMD [ "./config.sh" ]
