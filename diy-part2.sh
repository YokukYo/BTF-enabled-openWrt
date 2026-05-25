#!/bin/bash
# diy-part2.sh
# 执行时 pwd 为 openwrt/

cat >> .config << 'CONF'
# Kernel configurations
CONFIG_KERNEL_DEBUG_INFO=y
CONFIG_KERNEL_DEBUG_INFO_BTF=y
CONFIG_KERNEL_DEBUG_INFO_REDUCED=n
CONFIG_KERNEL_CGROUP_BPF=y

# ==========================================
# 🟢 第一类：绝对核心系统依赖包 (Essential Core)
# ==========================================
CONFIG_PACKAGE_base-files=y
CONFIG_PACKAGE_dropbear=y
CONFIG_PACKAGE_dnsmasq=y
CONFIG_PACKAGE_firewall4=y
CONFIG_PACKAGE_nftables=y
CONFIG_PACKAGE_kmod-nft-offload=y
CONFIG_PACKAGE_uci=y
CONFIG_PACKAGE_e2fsprogs=y
CONFIG_PACKAGE_mkf2fs=y
CONFIG_PACKAGE_kmod-fs-vfat=y

# ==========================================
# 🟡 第二类：下载与证书包 (SSL & Fetch Utilities)
# ==========================================
CONFIG_PACKAGE_ca-bundle=y
CONFIG_PACKAGE_libustream-mbedtls=y
CONFIG_PACKAGE_uclient-fetch=y

# DAE packages
CONFIG_PACKAGE_dae=y
CONFIG_PACKAGE_kmod-sched-bpf=y
CONFIG_PACKAGE_kmod-sched-core=y
CONFIG_PACKAGE_kmod-veth=y
CONFIG_PACKAGE_kmod-xdp-sockets-diag=y
CONFIG_PACKAGE_kmod-nft-bridge=y

# BBR Congestion Control (Missing module for congestion optimization)
CONFIG_PACKAGE_kmod-tcp-bbr=y

# Chinese Language UI (LuCI translation)
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y

# APK Package Manager (Alternative package manager)
CONFIG_PACKAGE_apk=y
CONFIG_PACKAGE_apk-mbedtls=y

# Web Interface (LuCI SSL)
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-ssl=y

# Utilities
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_ip-full=y
CONFIG_PACKAGE_tc-full=y
CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_htop=y
CONF

# Force BPF Events and Kprobes in target kernel configurations
# (Required for dae socket/event-based eBPF loading)
for f in target/linux/x86/config-* target/linux/generic/config-*; do
    if [ -f "$f" ]; then
        echo "CONFIG_BPF_EVENTS=y" >> "$f"
        echo "CONFIG_KPROBES=y" >> "$f"
        echo "CONFIG_KPROBE_EVENTS=y" >> "$f"
        echo "✔ Added BPF/KPROBE events to kernel config: $f"
    fi
done
