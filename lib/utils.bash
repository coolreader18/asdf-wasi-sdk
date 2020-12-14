#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/WebAssembly/wasi-sdk"

fail() {
  echo -e "asdf-wasi-sdk: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  # TODO: portable sort -V
  LC_ALL=C sort -V
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^wasi-sdk-//'
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version filename url os
  version="$1"
  filename="$2"

  case "$OSTYPE" in
    linux*) os=linux ;;
    darwin*) os=macos ;;
    msys*) os=mingw ;;
    *) fail "no prebuilt package for os" ;;
  esac

  url="$GH_REPO/releases/download/wasi-sdk-${version}/wasi-sdk-${version}.0-$os.tar.gz"

  echo "* Downloading wasi-sdk release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-wasi-sdk supports release installs only"
  fi

  local release_file="$install_path/wasi-sdk-$version.tar.gz"
  (
    mkdir -p "$install_path"
    mkdir -p "$install_path/bin"
    mkdir -p "$install_path/wasi-sdk"

    download_release "$version" "$release_file"
    tar -xzf "$release_file" -C "$install_path/wasi-sdk" --strip-components=1 || fail "Could not extract $release_file"
    rm "$release_file"

    install "$(dirname "$0")/../wasi-helper.sh" "$install_path/asdf-wasi-helper.sh"

    for bin in wasicc wasiclang wasic++ wasiclang++ wasild wasinm wasiar wasillvm-ar wasiranlib; do
      ln -s ../asdf-wasi-helper.sh "$install_path/bin/$bin"
    done

    echo "wasi-sdk $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing wasi-sdk $version."
  )
}
