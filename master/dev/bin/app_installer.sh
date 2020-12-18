#!/system/bin/sh
# Enable install FDisk
settings put secure install_non_market_apps 1
TOAST="am broadcast -a id.klampok.broadcast.CUSTOM_BROADCAST -e MSG "

$TOAST "Welcome to CendrawasihTV"
$TOAST "Preparation for installing..."
$TOAST "DON'T CLOSE OR POWEROFF YOUR DEVICE!!!"

# Install custom APK
find /system/app_install/ -name "*\.apk" -exec sh -c '$1 "Installing $(basename $0 .apk)"; pm install $0' {} "$TOAST" \;
## Install Split APK
#pm install-write -S

# Data configuration
cp -pr /system/data_default/* /data/

# Enable Writable System Dir
mount -o remount,rw /system
#mount -o remount,rw /dev

# Install Busybox
#$TOAST "Installing Busybox"
#su
#sleep 1
#sh /system/bin/busybox.bin

# grant some apps
#pm grant com.goplay.sport android.permission.WRITE_EXTERNAL_STORAGE
#pm grant com.goplay.sport android.permission.READ_EXTERNAL_STORAGE

# Moving Data
unzip -o /data/data.zip -d /data/data/ &> /dev/null
unzip -o /data/su.zip -d /data/data/ &> /dev/null
unzip -o /data/kodi.zip -d /data/data/ &> /dev/null
unzip -o /data/wifi.zip -d /data/misc/wifi/ &> /dev/null
#unzip -o /data/termux.zip -d /system/ &> /dev/null
sleep 100

# Termux installer
#sh /system/runmefirst.sh
#sleep 10

rm /data/data.zip
rm /data/su.zip
rm /data/kodi.zip
rm /data/wifi.zip
#rm /data/termux.zip

rm -rf /system/data_default
rm -rf /system/app_install
#rm /data/data1.zip

$TOAST "Installing done, refreshing.."
sleep 1

$TOAST "PATCHING U-BOOT"
#dd if=/data/bootloader.img of=/dev/block/bootloader &> /dev/null
dd if=/data/u-boot.bin of=/dev/block/bootloader &> /dev/null
rm /data/u-boot.bin
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
