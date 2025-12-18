FROM python:3.12-slim
RUN apt-get update && apt-get install -y curl

ARG FRACTAL_FEATURE_EXPLORER_VERSION
RUN python -m venv /app/venv
RUN /app/venv/bin/python -m pip install "fractal-feature-explorer==$FRACTAL_FEATURE_EXPLORER_VERSION"

COPY config.toml /app/
COPY run_dashboard.sh /app/
RUN chmod +x /app/run_dashboard.sh

RUN mkdir -p /app/.streamlit
COPY .streamlit/config.toml /app/.streamlit/

EXPOSE 8501

WORKDIR /app

CMD ["./run_dashboard.sh"]
