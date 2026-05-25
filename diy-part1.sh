#!/bin/bash
# diy-part1.sh
# 执行时 pwd 为 openwrt/

wget -q https://github.com/daeuniverse/openwrt-dae/archive/refs/heads/main.zip -O /tmp/openwrt-dae.zip
unzip -q /tmp/openwrt-dae.zip -d /tmp/
mv /tmp/openwrt-dae-main /tmp/openwrt-dae

cp -r /tmp/openwrt-dae/dae package/dae
cp -r /tmp/openwrt-dae/dae-geoip package/dae-geoip
cp -r /tmp/openwrt-dae/dae-geosite package/dae-geosite
