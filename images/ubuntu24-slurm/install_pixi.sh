#!/bin/bash

export PIXI_NO_PATH_UPDATE=1
export DO_NOT_TRACK=1
export PIXI_VERSION=0.84.2
export PIXI_HOME=/pixi/$PIXI_VERSION
curl -fsSL https://pixi.sh/install.sh | sh
chmod 755 "$PIXI_HOME" -R
