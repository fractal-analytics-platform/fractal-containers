FROM python:3.11-slim

ARG FRACTAL_CLIENT_VERSION
RUN pip install fractal-client==${FRACTAL_CLIENT_VERSION}

ENV FRACTAL_SERVER=http://head:8000
ENV FRACTAL_USER=admin@fractal.xy
ENV FRACTAL_PASSWORD=1234

CMD [ "fractal", "task", "collect", "/fractal_tasks_mock-0.0.1-py3-none-any.whl" ]
