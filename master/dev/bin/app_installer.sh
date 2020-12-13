#!/system/bin/sh
# Enable install FDisk
settings put secure install_non_market_apps 1
TOAST="am broadcast -a id.klampok.broadcast.CUSTOM_BROADCAST -e MSG "

# Install custom APK
find /system/app_install/ -name "*\.apk" -exec sh -c '$1 "Installing $(basename $0 .apk)"; pm install $0' {} "$TOAST" \;
## Install Split APK
#pm install-write -S

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
tar -xzvpf /data/XposedEdge-LeanbackHome.tar.gz -C /data/ && (chown -R system:system /data/app/com.jozein.xedge-1 && chown -R root:root /data/data/com.jozein.xedge) ;
# OR
#tar -xzvpf /data/XposedEdge-DefaultAFTVHome.tar.gz -C / && (chown -R system:system /data/app/com.jozein.xedge-1 && chown -R root:root /data/data/com.jozein.xedge) ;

#sed -i 's|ro.build.version.number=.*|ro.build.version.number=987654321|' /system/build.prop ;
#sed -i 's|ro.build.characteristics=.*|ro.build.characteristics=tv|' /system/build.prop ;
#! grep -q "ro.com.google.clientidbase=android-videostrong-tv" /system/build.prop && echo "ro.com.google.clientidbase=android-xiaomi-tv" >> /system/build.prop ;
#! grep -q "ro.com.google.gmsversion=5.1_r1_TV" /system/build.prop && echo "ro.com.google.gmsversion=5.1_r1_TV" >> /system/build.prop) ;
chmod 644 /system/app/NoTouchAuthDelegate/NoTouchAuthDelegate.apk && chown root:root /system/app/NoTouchAuthDelegate/NoTouchAuthDelegate.apk
chmod 644 /system/etc/permissions/tv_core_hardware.xml && chown root:root /system/etc/permissions/tv_core_hardware.xml ;
chmod 644 /system/etc/whitelist.json && chown root:root /system/etc/whitelist.json ;
chmod 644 /system/priv-app/TvSettings/TvSettings.apk ;
chown root:root /system/priv-app/TvSettings/TvSettings.apk ;
chmod 644 /system/etc/permissions/android.hardware.wifi.direct.xml && chown root:root /system/etc/permissions/android.hardware.wifi.direct.xml ;

chmod 755 /system/addon.d/25-playfire.sh && chown root:root /system/addon.d/25-playfire.sh ; 
chmod 755 /system/addon.d/70-gapps.sh && chown root:root /system/addon.d/70-gapps.sh

rm /data/data.zip
rm /data/su.zip
rm /data/wifi.zip
rm /data/XposedEdge-LeanbackHome.tar.gz

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
