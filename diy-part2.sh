#!/bin/bash
# 追加 BTF 和 dae 配置
cat >> .config << 'EOF'
CONFIG_KERNEL_DEBUG_INFO=y
CONFIG_KERNEL_DEBUG_INFO_BTF=y
CONFIG_KERNEL_DEBUG_INFO_REDUCED=n
CONFIG_KERNEL_CGROUP_BPF=y
CONFIG_PACKAGE_dae=y
CONFIG_PACKAGE_dae-geosite=y
CONFIG_PACKAGE_dae-geoip=y
CONFIG_PACKAGE_kmod-xdp-sockets-diag=y
CONFIG_PACKAGE_kmod-veth=y
CONFIG_PACKAGE_kmod-sched-core=y
CONFIG_PACKAGE_kmod-sched-bpf=y
CONFIG_PACKAGE_kmod-nft-bridge=y
EOF
