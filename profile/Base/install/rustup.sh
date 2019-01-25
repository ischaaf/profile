#!/usr/bin/env bash

if ! command -v rustup; then
  echo "Running rustup installer"
  curl https://sh.rustup.rs -sSf | bash
else
  echo "rustup already installed!"
fi
