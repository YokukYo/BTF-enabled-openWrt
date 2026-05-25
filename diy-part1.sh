#!/bin/bash
# diy-part1.sh - 在 feeds update 之前执行

# 克隆 openwrt-dae，复制 dae 包到编译树
git clone --depth 1 https://github.com/daeuniverse/openwrt-dae.git /tmp/openwrt-dae
cp -r /tmp/openwrt-dae/dae openwrt/package/dae
cp -r /tmp/openwrt-dae/dae-geoip openwrt/package/dae-geoip
cp -r /tmp/openwrt-dae/dae-geosite openwrt/package/dae-geosite
