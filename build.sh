#!/bin/bash
# build/repad.skprx (WSL: wsl -d Ubuntu-24.04 -- bash build.sh)
set -e
export VITASDK="${VITASDK:-$HOME/vitasdk}"
export PATH="$VITASDK/bin:$PATH"
cd "$(dirname "$0")"
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release > /dev/null # (Ninja: the Makefile generator breaks on paths with spaces)
cmake --build build
ls -l build/repad.skprx
