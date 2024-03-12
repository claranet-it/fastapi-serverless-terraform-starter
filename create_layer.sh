#!/bin/bash

DIR="$(pwd)"
DIST_DIR="$DIR/dist"
LAYER_NAME="layer"
LAYERS_DIR="$DIR/layers"

poetry export -f requirements.txt --output "$DIST_DIR/requirements.txt" --without-hashes

rm -rf "$DIST_DIR/layer"

pip install \
    --platform manylinux2014_x86_64 \
    --target=package \
    --implementation cp \
    --only-binary=:all: --upgrade \
    -r "$DIST_DIR/requirements.txt" \
    -t "$DIST_DIR/layer/python/"

cd "$DIST_DIR/layer" && zip -r9 "$LAYER_NAME.zip" .

cd ../../

mkdir -p "$LAYERS_DIR"

rm "$DIST_DIR/requirements.txt"