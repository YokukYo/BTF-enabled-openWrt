#!/bin/bash
# diy-part1.sh
# 执行时 pwd 为 openwrt/
set -e

mkdir -p package/dae/files

LATEST_URL=$(curl -s https://api.github.com/repos/daeuniverse/dae/releases/latest \
  | grep browser_download_url \
  | grep linux-x86_64.zip \
  | grep -v dgst \
  | cut -d '"' -f 4)

echo "Downloading dae from: $LATEST_URL"
wget -q -O /tmp/dae.zip "$LATEST_URL"
unzip -o /tmp/dae.zip -d /tmp/dae-bin

DAE_BIN=$(find /tmp/dae-bin -name 'dae-linux-*' -type f | head -1)
echo "Found binary: $DAE_BIN"
cp "$DAE_BIN" package/dae/files/dae
chmod +x package/dae/files/dae

cat > package/dae/files/dae.init << 'INIT'
#!/bin/sh /etc/rc.common
START=99
USE_PROCD=1

start_service() {
    [ -f /etc/dae/config.dae ] || return 0
    procd_open_instance
    procd_set_param command /usr/bin/dae run -c /etc/dae/config.dae
    procd_set_param respawn
    procd_set_param stdout 1
    procd_set_param stderr 1
    procd_close_instance
}

stop_service() {
    killall dae 2>/dev/null || true
}
INIT

chmod +x package/dae/files/dae.init

cat > package/dae/Makefile << 'MAKEFILE'
include $(TOPDIR)/rules.mk

PKG_NAME:=dae
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/dae
  SECTION:=net
  CATEGORY:=Network
  TITLE:=eBPF-based transparent proxy (official binary)
  URL:=https://github.com/daeuniverse/dae
endef

define Package/dae/description
  dae is a high-performance eBPF-based transparent proxy.
  This package uses the official prebuilt binary.
endef

define Build/Compile
endef

define Package/dae/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/dae $(1)/usr/bin/dae
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dae.init $(1)/etc/init.d/dae
	$(INSTALL_DIR) $(1)/etc/dae
endef

$(eval $(call BuildPackage,dae))
MAKEFILE

echo "dae package prepared successfully"
