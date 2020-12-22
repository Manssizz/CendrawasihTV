#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/Backdrop/Backdrop.apk
app/FrameworkPackageStubs/FrameworkPackageStubs.apk
app/FuguPairingTutorial/FuguPairingTutorial.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleJapaneseInput/GoogleJapaneseInput.apk
app/GoogleTTS/GoogleTTS.apk
app/GoogleTTS/lib/arm/libpatts_engine_jni_api_neon_ub.210307121.so
app/GoogleTTS/lib/arm/libpatts_engine_jni_api_ub.210307121.so
app/GoogleTTS/lib/arm/libspeexwrapper_ub.210307121.so
app/LandscapeWallpaper/LandscapeWallpaper.apk
app/Music2Pano/Music2Pano.apk
app/NoTouchAuthDelegate/NoTouchAuthDelegate.apk
app/PlayGames/PlayGames.apk
app/SecondScreenSetup/SecondScreenSetup.apk
app/SecondScreenSetupAuthBridge/SecondScreenSetupAuthBridge.apk
app/talkback/talkback.apk
app/VideosPano/VideosPano.apk
app/YouTubeLeanback/YouTubeLeanback.apk
etc/g.prop
etc/main_en.dict
etc/permissions/com.google.android.pano.v1.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.media.effects.xml
etc/sysconfig/dialer_experience.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/preferred-apps/google.xml
framework/com.google.android.pano.v1.jar
framework/com.google.android.dialer.support.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
media/audio/ui/pano_blip_alt.ogg
media/audio/ui/pano_click.ogg
media/audio/ui/pano_error.ogg
priv-app/AndroidMediaShell/AndroidMediaShell.apk
priv-app/AndroidMediaShell/lib/arm/libcast_media_1.0.so
priv-app/AndroidMediaShell/lib/arm/libcast_shell_android.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Katniss/Katniss.apk app/QuickSearchBox/QuickSearchBox.apk
priv-app/PhoneskyKamikazeCanvas/PhoneskyKamikazeCanvas.apk
priv-app/PrebuiltGmsCorePano/PrebuiltGmsCorePano.apk
priv-app/PrebuiltGmsCorePano/lib/arm/libAppDataSearch.so
priv-app/PrebuiltGmsCorePano/lib/arm/libappstreaming_jni.so
priv-app/PrebuiltGmsCorePano/lib/arm/libconscrypt_gmscore_jni.so
priv-app/PrebuiltGmsCorePano/lib/arm/libdirect-audio.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgcastv2_base.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgcastv2_support.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgmscore.so
priv-app/PrebuiltGmsCorePano/lib/arm/libgms-ocrclient.so
priv-app/PrebuiltGmsCorePano/lib/arm/libjgcastservice.so
priv-app/PrebuiltGmsCorePano/lib/arm/libleveldbjni.so
priv-app/PrebuiltGmsCorePano/lib/arm/libNearbyApp.so
priv-app/PrebuiltGmsCorePano/lib/arm/libwearable-selector.so
priv-app/PrebuiltGmsCorePano/lib/arm/libWhisper.so
priv-app/SetupWizard/SetupWizard.apk
priv-app/SetupWraith/SetupWraith.apk app/Provision/Provision.apk
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
    # Stub
  ;;
esac
