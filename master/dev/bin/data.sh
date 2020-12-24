#!/system/bin/sh
settings put secure install_non_market_apps 1
MARK=/data/local/symbol_thirdpart_apks_installed

# Data configuration
cp -pr /system/data_default/* /data/

# Enable Writable System Dir
mount -o remount,rw /system
#mount -o remount,rw /dev

echo "Extract Data"
# Moving Data
unzip -o /data/data.zip -d /data/data/ &> /dev/null
unzip -o /data/su.zip -d /data/data/ &> /dev/null
unzip -o /data/wifi.zip -d /data/misc/wifi/ &> /dev/null
sleep 10
unzip -o /data/kodi.zip -d /data/data/ &> /dev/null
sleep 30

rm /data/data.zip
rm /data/su.zip
rm /data/kodi.zip
rm /data/wifi.zip
#rm /data/termux.zip

#rm -rf /system/data_default
#rm -rf /system/preinstall
#rm /data/data1.zip

echo "Installing done, refreshing.."
sleep 1

echo "PATCHING U-BOOT"
#dd if=/data/bootloader.img of=/dev/block/bootloader &> /dev/null
dd if=/data/u-boot.bin of=/dev/block/bootloader &> /dev/null
rm /data/u-boot.bin
#rm /data/bootloader.img

echo "Cendrawasih TV"
echo "@Manssizz"
echo "Rebooting Device... Please Wait..."

# Give some delay for launcer to receive broadcast
sleep 10

# Kill app to force reload modified data/config
for f in /system/data_default/data/*/; do
	killall $(basename $f)
done

sleep 20
reboot