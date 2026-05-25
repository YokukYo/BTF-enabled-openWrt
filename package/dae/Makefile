include $(TOPDIR)/rules.mk

PKG_NAME:=dae
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/dae
  SECTION:=net
  CATEGORY:=Network
  TITLE:=dae official binary
endef

define Package/dae/description
 dae official binary
endef

define Build/Compile
endef

define Package/dae/install
	$(INSTALL_DIR) $(1)/usr/bin

	$(INSTALL_BIN) \
		./files/dae \
		$(1)/usr/bin/dae

	$(INSTALL_DIR) $(1)/etc/init.d

	$(INSTALL_BIN) \
		./files/dae.init \
		$(1)/etc/init.d/dae
endef

$(eval $(call BuildPackage,dae))
