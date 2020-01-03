#!/system/bin/sh

## The Ubports project
## Wait for WCNSS service to setup WLAN device over QMI

# Workaround for conn_init not copying the updated firmware
rm /data/misc/wifi/WCNSS_qcom_cfg.ini
rm /data/misc/wifi/WCNSS_qcom_wlan_nv.bin

echo 1 > /dev/wcnss_wlan

enable_bt () {

        if [[ `getprop ro.qualcomm.bt.hci_transport` != "smd" ]]; then
            setprop ro.qualcomm.bt.hci_transport smd
        fi

        #initialize bt device
        echo 0 > /sys/module/hci_smd/parameters/hcismd_set
        /system/bin/logwrapper -k /system/bin/hci_qcomm_init -vvv -e
        sleep 1
        echo 1 > /sys/module/hci_smd/parameters/hcismd_set

}

while true; do
    sleep 2
    if [ ! -f /sys/devices/fb000000.qcom,wcnss-wlan/net/wlan0/address ]; then
        echo sta > /sys/module/wlan/parameters/fwpath
    else
        # enable bluetooth here since we have to wait for wlan to be initialized
        enable_bt
        break
    fi
done
