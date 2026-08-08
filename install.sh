#!/usr/bin/env sh

set -e

if ! command -v cargo >/dev/null 2>&1; then
    echo "Rust is not installed."
    echo
    echo "Install it with:"
    echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    exit 1
fi

TMP_DIR="$(mktemp -d)"

git clone https://github.com/subtletea-research/ahelper.git "$TMP_DIR/ahelper"

cd "$TMP_DIR/ahelper"

cargo install --path .
