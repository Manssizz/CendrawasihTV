#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/AtvWidget/AtvWidget.apk
app/Backdrop/Backdrop.apk
app/BugReportSender/BugReportSender.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/LandscapeWallpaper/LandscapeWallpaper.apk
app/LeanbackIme/LeanbackIme.apk
app/NoTouchAuthDelegate/NoTouchAuthDelegate.apk
app/SecondScreenSetup/SecondScreenSetup.apk
app/SecondScreenSetupAuthBridge/SecondScreenSetupAuthBridge.apk
app/TvVoiceInput/TvVoiceInput.apk
etc/g.prop
etc/permissions/com.google.android.pano.v1.xml
etc/permissions/com.google.android.tv.installed.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
framework/com.google.android.pano.v1.jar
framework/com.google.widevine.software.drm.jar
priv-app/AtvCustomization/AtvCustomization.apk
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Katniss/Katniss.apk
priv-app/Katniss/lib/arm/libgoogle_hotword_jni.so
priv-app/Katniss/lib/arm/libgoogle_recognizer_jni_l.so
priv-app/LeanbackLauncher/LeanbackLauncher.apk
priv-app/Overscan/Overscan.apk
priv-app/PhoneskyKamikazeCanvas/PhoneskyKamikazeCanvas.apk
priv-app/PrebuiltGmsCorePano/PrebuiltGmsCorePano.apk
priv-app/PrebuiltGmsCorePano/lib/arm/libWhisper.so
priv-app/PrebuiltGmsCorePano/lib/arm/libconscrypt_gmscore_jni.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgcastv2_base.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgcastv2_support.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgmscore.so
priv-app/PrebuiltGmsCorePano/lib/arm/libjgcastservice.so
priv-app/PrebuiltGmsCorePano/lib/arm/libleveldbjni.so
priv-app/PrebuiltGmsCorePano/lib/arm/libvcdiffjni.so
priv-app/PrebuiltGmsCorePano/lib/arm/libwearable-selector.so
priv-app/SetupWraith/SetupWraith.apk
priv-app/TV/TV.apk
priv-app/TV/lib/arm/libtunertvinput_jni.so
EOF
}

# Backup/Restore using /sdcard if the installed GApps size plus a buffer for other addon.d backups (204800=200MB) is larger than /tmp
installed_gapps_size_kb=$(grep "^installed_gapps_size_kb" /tmp/gapps.prop | cut -d '=' -f 2)
if [ ! "$installed_gapps_size_kb" ]; then
  installed_gapps_size_kb="$(cd /system; size=0; for n in $(du -ak $(list_files) | cut -f 1); do size=$((size+n)); done; echo "$size")"
  echo "installed_gapps_size_kb=$installed_gapps_size_kb" >> /tmp/gapps.prop
fi

free_tmp_size_kb=$(grep "^free_tmp_size_kb" /tmp/gapps.prop | cut -d '=' -f 2)
if [ ! "$free_tmp_size_kb" ]; then
  free_tmp_size_kb="$(echo $(df -k /tmp | tail -n 1) | cut -d ' ' -f 4)"
  echo "free_tmp_size_kb=$free_tmp_size_kb" >> /tmp/gapps.prop
fi

buffer_size_kb=204800
if [ $((installed_gapps_size_kb + buffer_size_kb)) -ge "$free_tmp_size_kb" ]; then
  C=/sdcard/tmp-gapps
fi

case "$1" in
  backup)
    list_files | while read -r FILE DUMMY; do
      backup_file "$S"/"$FILE"
    done
  ;;
  restore)
    list_files | while read -r FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
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
    # Recreate required symlinks (from GApps Installer)

    # Apply build.prop changes (from GApps Installer)
    if ! grep -q "ro.opa.eligible_device=" /system/build.prop; then echo "ro.opa.eligible_device=true" >> /system/build.prop; fi
    sed -i "s/ro.error.receiver.system.apps=.*/ro.error.receiver.system.apps=com.google.android.gms/g" /system/build.prop

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in /system/app /system/priv-app /system/vendor/pittpatt /system/usr/srec; do
      if [ -d $i ]; then
        find $i -type d -exec rmdir -p '{}' \+ 2>/dev/null;
      fi
    done;
    # Fix ownership/permissions and clean up after backup and restore from /sdcard
    find /system/vendor/pittpatt -type d -exec chown 0:2000 '{}' \; # Change pittpatt folders to root:shell per Google Factory Settings
    for i in $(list_files); do
      chown root:root "/system/$i"
      chmod 644 "/system/$i"
      chmod 755 "$(dirname "/system/$i")"
    done
    rm -rf /sdcard/tmp-gapps
  ;;
esac
