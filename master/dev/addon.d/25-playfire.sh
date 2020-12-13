#!/sbin/sh

#############################################################################################
#############################################################################################																							
#  Modified from 70-gapps.sh by SimLynks for Prerooted ROM Updates on "Playing with Fire"   #
#											    #
#		PlayFire Updater Script (Version_v1) Release Date: July 8th, 2017)	    #
#											    #
#  SuperSU: forum.xda-developers.com/android/general/addon-d-supersu-backup-script-t3487215 #
#  XPosed:  forum.xda-developers.com/xposed/addon-d-script-xposed-to-survive-cm12-t3036886  #
#											    #
#		Compatible with both (ARM) and (ARM64) on Lollipop 5.0 & 5.1		    #
#											    #
# 	When flashing rbox ROM updates this script will preserve the Playing with Fire MOD  #
# https://forum.xda-developers.com/fire-tv/general/total-mod-playing-fire-complete-t3629990 #
#-------------------------------------------------------------------------------------------#
#  			"THE BEER-WARE LICENSE" (Revision 42):		  		    #
# 	<phk@FreeBSD.ORG> wrote this file.  As long as you retain this notice you	    #
# 	can do whatever you want with this stuff. If we meet some day, and you think	    #
# 	this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp	    #
#											    #
#############################################################################################
#############################################################################################

. /tmp/backuptool.functions

list_files() {
cat <<EOF
addon.d/10-xposed.sh
addon.d/15-supersu.sh
addon.d/20-playfire.sh
addon.d/25-playfire.sh
addon.d/70-gapps.sh
app/NoTouchAuthDelegate/NoTouchAuthDelegate.apk
priv-app/TvSettings/TvSettings.apk
etc/whitelist.json
etc/permissions/tv_core_hardware.xml
etc/permissions/android.hardware.wifi.direct.xml
bin/app_process32_xposed
bin/dex2oat
bin/oatdump
bin/patchoat
framework/XposedBridge.jar
lib/libart-compiler.so
lib/libart-disassembler.so
lib/libart.so
lib/libsigchain.so
lib/libxposed_art.so
bin/app_process64_xposed
lib64/libart.so
lib64/libart-compiler.so
lib64/libart-disassembler.so
lib64/libsigchain.so
lib64/libxposed_art.so
xposed.prop
app/SuperSU/SuperSU.apk
etc/install-recovery.sh
bin/install-recovery.sh
xbin/su
bin/.ext/.su
xbin/daemonsu
xbin/supolicy
lib(64)/libsupol.so
bin/app_process32_original
bin/app_process64_original
bin/app_process_init
bin/app_process
bin/app_process32
bin/app_process64
etc/.installed_su_daemon
EOF
}
case "$1" in                                                                                 
  backup)                                                                                    
    list_files | while read FILE DUMMY; do                                                   
      backup_file $S/$FILE                                                                   
    done                                                                                     
  ;;                                                                                         
  restore)                                                                                   
    list_files | while read FILE REPLACEMENT; do                                             
      R=""                                                                                   
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"                                           
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R                                       
    done  
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
# BUILD.PROP Modification & Save Backuo of Unedited file in /sdcard/backup.buildprop
cp /system/build.prop /sdcard/backup.buildprop                                                           
sed -i 's|ro.build.version.number=.*|ro.build.version.number=987654321|' /system/build.prop                      
sed -i 's|ro.build.characteristics=.*|ro.build.characteristics=tv|' /system/build.prop                                                 
! grep -q "ro.com.google.clientidbase=android-xiaomi-tv" /system/build.prop && echo "ro.com.google.clientidbase=android-xiaomi-tv" >> /system/build.prop
! grep -q "ro.com.google.gmsversion=5.1_r1_TV" /system/build.prop && echo "ro.com.google.gmsversion=5.1_r1_TV" >> /system/build.prop 
# /system/bin/app_process32_xposed
chmod 0755 /system/bin/app_process32_xposed
chown root:shell /system/bin/app_process32_xposed
chcon u:object_r:zygote_exec:s0 /system/bin/app_process32_xposed
# /system/bin/app_process64_xposed
chmod 0755 /system/bin/app_process64_xposed
chown root:shell /system/bin/app_process64_xposed
chcon u:object_r:zygote_exec:s0 /system/bin/app_process64_xposed
# /system/bin/dex2oat
chmod 0755 /system/bin/dex2oat
chown root:shell /system/bin/dex2oat
chcon u:object_r:dex2oat_exec:s0 /system/bin/dex2oat
# /system/bin/oatdump
chmod 0755 /system/bin/oatdump
chown root:shell /system/bin/oatdump
chcon u:object_r:system_file:s0 /system/bin/oatdump
# /system/bin/patchoat
chmod 0755 /system/bin/patchoat
chown root:shell /system/bin/patchoat
chcon u:object_r:dex2oat_exec:s0 /system/bin/patchoat
# /system/framework/XposedBridge.jar
chmod 0644 /system/framework/XposedBridge.jar
chown root:root /system/framework/XposedBridge.jar
chcon u:object_r:system_file:s0 /system/framework/XposedBridge.jar
# /system/lib/libart-compiler.so
chmod 0644 /system/lib/libart-compiler.so
chown root:root /system/lib/libart-compiler.so
chcon u:object_r:system_file:s0 /system/lib/libart-compiler.so
# /system/lib/libart-disassembler.so
chmod 0644 /system/lib/libart-disassembler.so
chown root:root /system/lib/libart-disassembler.so
chcon u:object_r:system_file:s0 /system/lib/libart-disassembler.so
# /system/lib/libart.so
chmod 0644 /system/lib/libart.so
chown root:root /system/lib/libart.so
chcon u:object_r:system_file:s0 /system/lib/libart.so
# /system/lib/libsigchain.so
chmod 0644 /system/lib/libsigchain.so
chown root:root /system/lib/libsigchain.so
chcon u:object_r:system_file:s0 /system/lib/libsigchain.so
# /system/lib/libxposed_art.so
chmod 0644 /system/lib/libxposed_art.so
chown root:root /system/lib/libxposed_art.so
chcon u:object_r:system_file:s0 /system/lib/libxposed_art.so
# /system/xposed.prop
chmod 0644 /system/xposed.prop
chown root:root /system/xposed.prop
chcon u:object_r:system_file:s0 /system/xposed.prop
  ;;
esac
