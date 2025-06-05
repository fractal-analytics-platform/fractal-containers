#!/bin/bash

export PIXI_HOME=/home/fractal_share/tasks/pixi/0.47.0
export PIXI_VERSION="0.47.0"
echo "Now create $PIXI_HOME"
mkdir -p "$PIXI_HOME"
ls -l "$PIXI_HOME/.."
echo "Now download pixi"
curl -fsSL https://pixi.sh/install.sh | sh
echo "End"
