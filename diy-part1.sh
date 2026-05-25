#!/bin/bash

set -e

mkdir -p package/dae/files

LATEST_URL=$(curl -s https://api.github.com/repos/daeuniverse/dae/releases/latest \
  | grep browser_download_url \
  | grep linux-x86_64.zip \
  | cut -d '"' -f 4)

echo "Latest dae release:"
echo "$LATEST_URL"

wget -O /tmp/dae.zip "$LATEST_URL"

unzip -o /tmp/dae.zip -d /tmp/dae-bin

chmod +x /tmp/dae-bin/dae

cp /tmp/dae-bin/dae package/dae/files/dae

chmod +x package/dae/files/dae.init
