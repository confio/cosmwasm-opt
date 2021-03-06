#!/bin/bash
set -o errexit -o nounset -o pipefail
command -v shellcheck > /dev/null && shellcheck "$0"

export PATH="$PATH:/root/.cargo/bin"

rustup toolchain list
cargo --version

optimize_workspace.py

# Postprocess artifacts
(
  cd artifacts
  chmod -x ./*.wasm
  sha256sum -- *.wasm > checksums.txt
)

echo "done"
