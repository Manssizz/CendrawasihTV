#!/system/bin/sh
# Enable install FDisk
settings put secure install_non_market_apps 1
TOAST="am broadcast -a id.klampok.broadcast.CUSTOM_BROADCAST -e MSG "

# Install custom APK
find /system/app_install/ -name "*\.apk" -exec sh -c '$1 "Installing $(basename $0 .apk)"; pm install $0' {} "$TOAST" \;


# Data configuration
cp -pr /system/data_default/* /data/

# Enable Writable System Dir
mount -o remount,rw /system
#mount -o remount,rw /dev

# grant some apps
#pm grant com.goplay.sport android.permission.WRITE_EXTERNAL_STORAGE
#pm grant com.goplay.sport android.permission.READ_EXTERNAL_STORAGE

# Moving Data
unzip -o /data/data.zip -d /data/data/ &> /dev/null
unzip -o /data/su.zip -d /data/data/ &> /dev/null
unzip -o /data/wifi.zip -d /data/misc/wifi/ &> /dev/null


rm /data/data.zip
rm /data/su.zip
rm /data/wifi.zip


rm -rf /system/data_default
rm -rf /system/app_install
#rm /data/data1.zip

$TOAST "Installing done, refreshing.."
sleep 1

$TOAST "PATCHING U-BOOT"
dd if=/data/boot.img of=/dev/block/boot &> /dev/null
#dd if=/data/bootloader.img of=/dev/block/bootloader &> /dev/null
dd if=/data/u-boot.bin of=/dev/block/bootloader &> /dev/null
rm /data/u-boot.bin
rm /data/boot.img
#rm /data/bootloader.img

$TOAST "Cendrawasih TV"
$TOAST "@Manssizz"
$TOAST "Rebooting Device... Please Wait..."

# Give some delay for launcer to receive broadcast
sleep 10

# Kill app to force reload modified data/config
for f in /system/data_default/data/*/; do
	killall $(basename $f)
done

sleep 1
reboot
