#!/bin/bash

sudo apt update -y

sudo apt install -y \
curl \
jq \
git \
python3 \
python3-pip \
python3-venv \
build-essential

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

sudo apt install -y nodejs

curl -fsSL https://install.iii.dev/iii/main/install.sh | sh

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc