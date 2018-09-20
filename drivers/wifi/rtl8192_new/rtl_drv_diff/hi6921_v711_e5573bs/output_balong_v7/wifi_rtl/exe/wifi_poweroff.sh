#!/system/bin/busybox sh

WIFI_FLAGS_FILE=/system/bin/wifi_rtl/exe/wifi_flags.sh
if [ -e ${WIFI_FLAGS_FILE} ];then
	. ${WIFI_FLAGS_FILE}
fi
if [ -z "${CONFIG_WLAN_MODULE_NAME}" ];then
	CONFIG_WLAN_MODULE_NAME=rtl8192es
fi

echo "hi_mci.0" > /sys/bus/platform/drivers/hi_mci/unbind
WIFI_RESULT=$?
echo "[wi-fi]: sdio unbind ret = ${WIFI_RESULT}"

echo "10 shutdown 8192:wifi_rtl" > /sys/devices/platform/wifi_at_dev/wifi_at_dev
echo "[wi-fi]: wifi chip power off = $?"









exit ${WIFI_RESULT}
