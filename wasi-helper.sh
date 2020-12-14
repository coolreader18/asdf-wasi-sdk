#!/usr/bin/env bash

set -euo pipefail

clang=''

args=()

case "$(basename "$0")" in
  wasicc | wasiclang)
    bin=clang
    clang=1
    ;;
  wasic++ | wasiclang++)
    bin=clang++
    clang=1
    ;;
  wasild)
    bin=wasm-ld
    args+=(-lwasi-emulated-signal)
    ;;
  wasinm) bin=llvm-nm ;;
  wasiar | wasillvm-ar) bin=llvm-ar ;;
  wasiranlib) bin=llvm-ranlib ;;
  *)
    echo "unknown binary" >&2
    exit 1
    ;;
esac

{
  if which realpath; then
    real0="$(realpath "$0")"
  else
    real0="$(dirname "$0")/$(readlink "$0")"
  fi

  installdir="$(dirname "$real0")"
} >/dev/null 2>&1

if [[ $clang ]]; then
  args+=(--sysroot "$installdir/wasi-sdk/share/wasi-sysroot")
  args+=(-D_WASI_EMULATED_SIGNAL)
fi

exec "$installdir/wasi-sdk/bin/$bin" "${args[@]}" "$@"
