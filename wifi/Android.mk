LOCAL_PATH:= $(call my-dir)

#----------------------------------------------------------------------
# Copy additional target-specific files
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
include $(CLEAR_VARS)
LOCAL_MODULE       := wpa_supplicant_overlay.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := p2p_supplicant_overlay.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/wifi
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd_default.conf
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
LOCAL_SRC_FILES    := hostapd.conf
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd.accept
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
LOCAL_SRC_FILES    := hostapd.accept
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := hostapd.deny
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH  := $(TARGET_OUT_ETC)/hostapd
LOCAL_SRC_FILES    := hostapd.deny
include $(BUILD_PREBUILT)

# Workaround for broken / incompatible MAC addresses stored in NVRAM. Rather try to symlink to the config file in /persist, this seems to contain a valid MAC addy
# See https://github.com/ubports/ubuntu-touch/issues/541
$(shell mkdir -p $(PRODUCT_OUT)/$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/wlan/prima)
$(shell pushd $(PRODUCT_OUT)/$(TARGET_COPY_OUT_SYSTEM) > /dev/null && ln -s /persist/WCNSS_qcom_cfg.ini etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini && popd > /dev/null)
$(shell mkdir -p $(PRODUCT_OUT)/$(TARGET_COPY_OUT_SYSTEM)/etc/wifi)
$(shell pushd $(PRODUCT_OUT)/$(TARGET_COPY_OUT_SYSTEM) > /dev/null && ln -s /persist/WCNSS_qcom_cfg.ini etc/wifi/WCNSS_qcom_cfg.ini && popd > /dev/null)

endif
