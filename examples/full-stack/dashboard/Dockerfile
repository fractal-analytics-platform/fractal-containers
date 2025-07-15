FROM python:3.12-slim

ARG FRACTAL_FEATURE_EXPLORER_VERSION

RUN mkdir /app
RUN mkdir /app/.streamlit

RUN python -m venv /app/venv
RUN /app/venv/bin/python -m pip install "fractal-feature-explorer==$FRACTAL_FEATURE_EXPLORER_VERSION"

COPY run_dashboard.sh /app/
COPY config.toml /app/
COPY .streamlit/config.toml /app/.streamlit/

RUN chmod +x /app/run_dashboard.sh

CMD [ "/app/run_dashboard.sh" ]
