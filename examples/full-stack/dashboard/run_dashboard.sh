#!/bin/bash

set -e

cd /app

export FRACTAL_FEATURE_EXPLORER_CONFIG=/app/config.toml

source /app/venv/bin/activate

APP_FILE=$(python -c "import fractal_feature_explorer.main; print(fractal_feature_explorer.main.__file__)")

streamlit run "$APP_FILE"
