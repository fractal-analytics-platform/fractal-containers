#!/bin/bash

set -eu

export FRACTAL_FEATURE_EXPLORER_CONFIG=/app/config.toml

# shellcheck disable=SC1091
source venv/bin/activate

APP_FILE=$(python -c "import fractal_feature_explorer.main; print(fractal_feature_explorer.main.__file__)")

streamlit run "$APP_FILE"
