FROM python:3.11-slim

ARG FRACTAL_CLIENT_VERSION
RUN pip install fractal-client==${FRACTAL_CLIENT_VERSION}

ENV FRACTAL_SERVER=http://head:8000
ENV FRACTAL_USER=admin@fractal.xy
ENV FRACTAL_PASSWORD=1234

COPY config.sh ./

CMD [ "./config.sh" ]
