#!/bin/bash
SYSDIR="mod/system"
SYSIMG="mod/system.img"
red='\033[31m'
no='\033[0m'
yellow='\e[33m'
blue='\e[34m'
green='\e[32m'
#clean= "umount mod/system/ && rm mod/system.img"
[ "$UID" = "0" ] || exec sudo "$0" "$@"
clear

echo -e "+--------------------------------------------+"
echo -e "|             ${red}CendrawasihTV${no}                  |"
echo -e "|     github.com/manssizz/CendrawasihTV      |"
echo -e "|       ${yellow}Don't forget to read BUILD.MD${no}        |"
echo -e "+--------------------------------------------+"

PS3='Select your device: '
options=("ZTE B860H v1" "ZTE B860H v2" "Developer Build" "Unlock Bootloader" "Flash" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "ZTE B860H v1")
            clear
            echo -e "${green}Copy original firmware...${no}"
            cp -v original/v1/system.img $SYSIMG || exit 1
            chmod 777 $SYSIMG


            echo -e "${yellow}Mounting system.img to $SYSDIR ${no}"
            [ -d $SYSDIR ] || mkdir $SYSDIR
            mount -o loop,noatime,rw,sync $SYSIMG $SYSDIR

### Modding Script
            echo -e "${red}Remove 3rd Apps (indihome) ${no}"
            rm -rf $SYSDIR/preinstall

            echo -e "${red}Remove Unwanted Apps${no}"
### Remove Dir
            rm -rf $SYSDIR/app/apk
            rm -rf $SYSDIR/app/AppInstaller
            rm -rf $SYSDIR/app/AppsListApi
            rm -rf $SYSDIR/app/AuthConfig
            rm -rf $SYSDIR/app/Browser
                  rm -rf $SYSDIR/app/FileBrowser
            rm -rf $SYSDIR/priv-app/Gallery2
            rm -rf $SYSDIR/app/HomeMediaCenter
            rm -rf $SYSDIR/app/NetworkTest
            rm -rf $SYSDIR/app/QuickSearchBox
            rm -rf $SYSDIR/app/SubtitleService
            rm -rf $SYSDIR/app/ztehelper

### Remove Packages
            rm -f $SYSDIR/app/ajvm.apk
                  rm -f $SYSDIR/app/apm-targetad_ti-zte860_v2.3.0_230-release.apk
                  rm -f $SYSDIR/app/FactoryTestTool.apk
            rm -f $SYSDIR/app/IPTV.apk
            rm -f $SYSDIR/app/iptvclient_boot-release.apk
            rm -f $SYSDIR/app/Licauth.apk
                  rm -f $SYSDIR/app/MSGAPK.apk            
            rm -f $SYSDIR/app/MSGAPKSub.apk
            rm -f $SYSDIR/app/popup-release-signed.apk
            rm -f $SYSDIR/app/signed_UseeStore_v0.9.2.apk
            rm -f $SYSDIR/app/signed-control-release-0.0.0.4.7.apk
            rm -f $SYSDIR/app/SubtitleService.apk
            rm -f $SYSDIR/app/ZTE*.apk

### MeBox launcher
            rm -f $SYSDIR/app/launcher_tkz4.apk

### Must removed if using GAPPS TV
            rm -rf $SYSDIR/app/Camera2
            rm -rf $SYSDIR/app/Music
            rm -rf $SYSDIR/app/DownloadProviderUi
            rm -f $SYSDIR/app/com.google.android.tts-3.10.10-210310101.apk
            rm -rf $SYSDIR/priv-app/Contacts/
            rm -rf $SYSDIR/priv-app/LiveTv/

### Uncomment if you want use hardware keyboard only (no softkeyboard)
            #rm -rf $SYSDIR/app/LatinIME
            #rm -rf $SYSDIR/app/OpenWnn

            echo -e "${red}Remove Unwanted services${no}"
            rm -f $SYSDIR/bin/netaccess
            rm -f $SYSDIR/bin/depconfig

            echo -e "${yellow}Bootanimation${no}"
            pushd master/bootanimation
            [ -e ../v1/media/bootanimation.zip ] && sudo rm ../v1/media/bootanimation.zip
            [ -d ../v1/media ] || mkdir ../v1/media
            sudo zip -0 -r '../v1/media/bootanimation.zip' *
            popd

            echo -e "${yellow}Coying default data${no}"
            #[ -d master/v1/data_default ] || mkdir -p master/v1/data_default/data
            #Fix data permissions, its changed after checkout from git
            #chmod -R og+rw master/v1/data_default/data/*
            chmod -R +x master/v1/xbin/*
            chmod -R +x master/v1/bin/*
            
            
            echo -e "${yellow}Merge master file to $SYSDIR ${no}"
            cp -pruv master/v1/* $SYSDIR/
            unzip -o master/fonts.zip -d $SYSDIR/fonts/
            
            
            echo -e "${yellow}Unmount $SYSDIR${no}"
            umount $SYSDIR

            if which e2fsck &> /dev/null; then
                echo -e "${yellow}Check/repair file system.img${no}"
                e2fsck -f $SYSIMG -y
            fi

            if which resize2fs &> /dev/null; then
                # kecilkan partisi biar ga lama bgt ngeflashnya
                echo -e "${yellow}Minimizing system.img${no}"
                resize2fs -M $SYSIMG
            fi
        
	    echo -e "${yellow}Modified system saved to mod folder${no}"
            echo -e "${green}Done, press any key to close${no}"
            read -n 1
            ;;


        "ZTE B860H v2")        
            clear
            echo -e "${green}Copy original firmware...${no}"
            cp -v original/v2/system.img $SYSIMG || exit 1
            chmod 777 $SYSIMG

            echo -e "${yellow}Mounting system.img to $SYSDIR ${no}"
            [ -d $SYSDIR ] || mkdir $SYSDIR
            mount -o loop,noatime,rw,sync $SYSIMG $SYSDIR

### Modding Script
            echo -e "${red}Remove 3rd Apps (indihome) ${no}"
            rm -rf $SYSDIR/preinstall

            echo -e "${red}Remove Unwanted Apps${no}"
### Remove Dir
            rm -rf $SYSDIR/app/apk
            rm -rf $SYSDIR/app/AppInstaller
            rm -rf $SYSDIR/app/AppsListApi
            rm -rf $SYSDIR/app/AuthConfig
            rm -rf $SYSDIR/app/Browser
                  rm -rf $SYSDIR/app/FileBrowser
            rm -rf $SYSDIR/priv-app/Gallery2
            rm -rf $SYSDIR/app/HomeMediaCenter
            rm -rf $SYSDIR/app/NetworkTest
            rm -rf $SYSDIR/app/QuickSearchBox
            rm -rf $SYSDIR/app/SubtitleService
            rm -rf $SYSDIR/app/ztehelper

### Remove Packages
            rm -f $SYSDIR/app/ajvm.apk
                  rm -f $SYSDIR/app/apm-targetad_ti-zte860_v2.3.0_230-release.apk
                  rm -f $SYSDIR/app/FactoryTestTool.apk
            rm -f $SYSDIR/app/IPTV.apk
            rm -f $SYSDIR/app/iptvclient_boot-release.apk
            rm -f $SYSDIR/app/Licauth.apk
                  rm -f $SYSDIR/app/MSGAPK.apk            
            rm -f $SYSDIR/app/MSGAPKSub.apk
            rm -f $SYSDIR/app/popup-release-signed.apk
            rm -f $SYSDIR/app/signed_UseeStore_v0.9.2.apk
            rm -f $SYSDIR/app/signed-control-release-0.0.0.4.7.apk
            rm -f $SYSDIR/app/SubtitleService.apk
            rm -f $SYSDIR/app/ZTE*.apk

### MeBox launcher
            rm -f $SYSDIR/app/launcher_tkz4.apk

### Must removed if using GAPPS TV
            rm -rf $SYSDIR/app/Camera2
            rm -rf $SYSDIR/app/Music
            rm -rf $SYSDIR/app/DownloadProviderUi
            rm -f $SYSDIR/app/com.google.android.tts-3.10.10-210310101.apk
            rm -rf $SYSDIR/priv-app/Contacts/
            rm -rf $SYSDIR/priv-app/LiveTv/

### Uncomment if you want use hardware keyboard only (no softkeyboard)
            #rm -rf $SYSDIR/app/LatinIME
            #rm -rf $SYSDIR/app/OpenWnn

            echo -e "${red}Remove Unwanted services${no}"
            rm -f $SYSDIR/bin/netaccess
            rm -f $SYSDIR/bin/depconfig

            echo -e "${yellow}Remove extra packages${no}"
            rm -rf $SYSDIR/app/cleanXperience-v2
            rm -rf $SYSDIR/app/Mebox_1.1.3.58.apk
            rm -rf $SYSDIR/app/snowball.apk
            rm -rf $SYSDIR/app/Superuser.apk
            rm -rf $SYSDIR/app/Root_Exploler.apk
            rm -rf $SYSDIR/app/ATV_Launcher.apk
            rm -f $SYSDIR/app/keyboard.apk


			echo -e "${yellow}Remove Old Gapps ${no}"
            rm -rf $SYSDIR/app/com.google.android.youtube.tv-1
			rm -rf $SYSDIR/app/GoogleContactsSyncAdapter
			rm -rf $SYSDIR/app/GoogleJapaneseInput
			rm -rf $SYSDIR/app/GoogleTTS
            rm -rf $SYSDIR/app/PlayGamesPano
			rm -rf $SYSDIR/priv-app/GoogleBackupTransport
			rm -rf $SYSDIR/priv-app/GoogleServicesFramework
            rm -rf $SYSDIR/priv-app/Phonesky
            rm -rf $SYSDIR/priv-app/PrebuiltGmsCorePano

            
            echo -e "${yellow}Bootanimation${no}"
            pushd master/bootanimation
            [ -e ../v2/media/bootanimation.zip ] && sudo rm ../v2/media/bootanimation.zip
            [ -d ../v2/media ] || mkdir ../v2/media
            sudo zip -0 -r '../v2/media/bootanimation.zip' *
            popd

            echo -e "${yellow}Coying default data${no}"
#            [ -d master/v1/data_default ] || mkdir -p master/v2/data_default/data
#             Fix data permissions, its changed after checkout from git
#            chmod -R og+rw master/v2/data_default/data/*
            chmod -R +x master/v1/xbin/*
            chmod -R +x master/v1/bin/*
#            chmod -R +x master/v2/xbin/*
#            chmod -R +x master/v2/bin/*

            echo -e "${yellow}Merge master file to $SYSDIR ${no}"
            cp -pruv master/v1/* $SYSDIR/
            cp -pruv master/v2/* $SYSDIR/
            #cp -pruv gapps_beta/rootfs_gapps/* $SYSDIR/
#            unzip -o master/fonts.zip -d $SYSDIR/fonts/
            #rm master/v2/app/klampok.apk

            echo -e "${yellow}Unmount $SYSDIR${no}"
            umount $SYSDIR

            if which e2fsck &> /dev/null; then
                echo -e "${yellow}Check/repair file system.img${no}"
                e2fsck -f $SYSIMG -y
            fi

            if which resize2fs &> /dev/null; then
                # kecilkan partisi biar ga lama bgt ngeflashnya
                echo -e "${yellow}Minimizing system.img${no}"
                resize2fs -M $SYSIMG
            fi
        
	      echo -e "${yellow}Modified system saved to mod folder${no}"
            echo -e "${green}Done, press any key to close${no}"
            read -n 1
            ;;


        "Developer Build")
 	    clear
            echo -e "${green}Copy original firmware...${no}"
            cp -v original/v2/system.img $SYSIMG || exit 1
            chmod 777 $SYSIMG

            echo -e "${yellow}Mounting system.img to $SYSDIR ${no}"
            [ -d $SYSDIR ] || mkdir $SYSDIR
            mount -o loop,noatime,rw,sync $SYSIMG $SYSDIR

### Modding Script
            echo -e "${red}Remove 3rd Apps (indihome) ${no}"
            rm -rf $SYSDIR/preinstall

            echo -e "${red}Remove Unwanted Apps${no}"
### Remove Dir
            rm -rf $SYSDIR/app/apk
            rm -rf $SYSDIR/app/AppInstaller
            rm -rf $SYSDIR/app/AppsListApi
            rm -rf $SYSDIR/app/AuthConfig
            rm -rf $SYSDIR/app/Browser
                  rm -rf $SYSDIR/app/FileBrowser
            rm -rf $SYSDIR/priv-app/Gallery2
            rm -rf $SYSDIR/app/HomeMediaCenter
            rm -rf $SYSDIR/app/NetworkTest
            rm -rf $SYSDIR/app/QuickSearchBox
            rm -rf $SYSDIR/app/SubtitleService
            rm -rf $SYSDIR/app/ztehelper

### Remove Packages
            rm -f $SYSDIR/app/ajvm.apk
                  rm -f $SYSDIR/app/apm-targetad_ti-zte860_v2.3.0_230-release.apk
                  rm -f $SYSDIR/app/FactoryTestTool.apk
            rm -f $SYSDIR/app/IPTV.apk
            rm -f $SYSDIR/app/iptvclient_boot-release.apk
            rm -f $SYSDIR/app/Licauth.apk
                  rm -f $SYSDIR/app/MSGAPK.apk            
            rm -f $SYSDIR/app/MSGAPKSub.apk
            rm -f $SYSDIR/app/popup-release-signed.apk
            rm -f $SYSDIR/app/signed_UseeStore_v0.9.2.apk
            rm -f $SYSDIR/app/signed-control-release-0.0.0.4.7.apk
            rm -f $SYSDIR/app/SubtitleService.apk
            rm -f $SYSDIR/app/ZTE*.apk

### MeBox launcher
            rm -f $SYSDIR/app/launcher_tkz4.apk

### Must removed if using GAPPS TV
            rm -rf $SYSDIR/app/Camera2
            rm -rf $SYSDIR/app/Music
            rm -rf $SYSDIR/app/DownloadProviderUi
            rm -f $SYSDIR/app/com.google.android.tts-3.10.10-210310101.apk
            rm -rf $SYSDIR/priv-app/Contacts/
            rm -rf $SYSDIR/priv-app/LiveTv/

### Uncomment if you want use hardware keyboard only (no softkeyboard)
            #rm -rf $SYSDIR/app/LatinIME
            #rm -rf $SYSDIR/app/OpenWnn

            echo -e "${red}Remove Unwanted services${no}"
            rm -f $SYSDIR/bin/netaccess
            rm -f $SYSDIR/bin/depconfig

            echo -e "${yellow}Remove extra packages${no}"
            rm -rf $SYSDIR/app/cleanXperience-v2
            rm -rf $SYSDIR/app/Mebox_1.1.3.58.apk
            rm -rf $SYSDIR/app/snowball.apk
            rm -rf $SYSDIR/app/Superuser.apk
            rm -rf $SYSDIR/app/Root_Exploler.apk
            rm -rf $SYSDIR/app/ATV_Launcher.apk
            rm -f $SYSDIR/app/keyboard.apk

            echo -e "${yellow}Remove Old Gapps ${no}"
            rm -rf $SYSDIR/bless
            rm -rf $SYSDIR/app/com.google.android.youtube.tv-1
            rm -rf $SYSDIR/app/TerminalEmulator
            rm -rf $SYSDIR/app/Browser
            rm -rf $SYSDIR/app/GoogleCalendarSyncAdapter
            rm -rf $SYSDIR/app/GoogleContactsSyncAdapter
            rm -rf $SYSDIR/app/GoogleJapaneseInput
            rm -rf $SYSDIR/app/GoogleTTS
            rm -rf $SYSDIR/app/PlayGamesPano
            rm -rf $SYSDIR/priv-app/GmsCore
            rm -rf $SYSDIR/priv-app/GoogleBackupTransport
            rm -rf $SYSDIR/priv-app/GoogleLoginService
            rm -rf $SYSDIR/priv-app/GoogleServicesFramework
            rm -rf $SYSDIR/priv-app/Phonesky
            rm -rf $SYSDIR/priv-app/PrebuiltGmsCorePano
            rm -rf $SYSDIR/priv-app/Velvet

            ### Dont erase this dir or your device will brick
#            rm -rf $SYSDIR/priv-app/GoogleOneTimeInitializer
#            rm -rf $SYSDIR/priv-app/OneTimeInitializer
#            rm -rf $SYSDIR/priv-app/GooglePackageInstaller
#            rm -rf $SYSDIR/priv-app/PackageInstaller

            echo -e "${yellow}Bootanimation${no}"
            pushd master/bootanimation
            [ -e ../dev/media/bootanimation.zip ] && sudo rm ../dev/media/bootanimation.zip
            [ -d ../dev/media ] || mkdir ../dev/media
            sudo zip -0 -r '../dev/media/bootanimation.zip' *
            popd

            echo -e "${yellow}Coying default data${no}"
#            [ -d master/dev/data_default ] || mkdir -p master/dev/data_default/data
#             Fix data permissions, its changed after checkout from git
#            chmod -R og+rw master/dev/data_default/data/*
            chmod -R +x master/v1/bin/*
            chmod -R +x master/v1/xbin/*
            chmod -R +x master/dev/bin/*
            chmod -R +x master/dev/xbin/*

            echo -e "${yellow}Merge master file to $SYSDIR ${no}"
            cp -pruv master/v1/* $SYSDIR/
            cp -pruv master/dev/* $SYSDIR/
#            find master/dev/ -mindepth 1 -maxdepth 1 -type d ! -regex '\(.*data_default\)' -exec cp -r {} $SYSDIR/ \;
#            zip -ur $SYSDIR/data_default/data.zip master/data_optional/org.xbmc.kodi


            #cp -pruv gapps_beta/rootfs_gapps/* $SYSDIR/
#            unzip -o master/fonts.zip -d $SYSDIR/fonts/
            rm $SYSDIR/app/klampok.apk
#            rm $SYSDIR/app/TerminalEmulator.apk 
#            echo -e "{yellow}Add script app_installer${no}"
#            sed -i '14i $TOAST "Installing Busybox"' $SYSDIR/bin/app_installer.sh
#            sed -i '15i sh /system/bin/busybox.bin' $SYSDIR/bin/app_installer.sh
#            sed -i '30i unzip -o /data/kodi.zip -d /data/data/ &> /dev/null' $SYSDIR/bin/app_installer.sh
#            sed -i '31i unzip -o /data/termux.zip -d /system/ &> /dev/null' $SYSDIR/bin/app_installer.sh
#            sed -i '35i rm /data/kodi.zip' $SYSDIR/bin/app_installer.sh
#            sed -i '36i rm /data/termux.zip' $SYSDIR/bin/app_installer.sh
#            sed -i '37i sh /system/runmefirst.sh' $SYSDIR/bin/app_installer.sh


            echo -e "${yellow}Unmount $SYSDIR${no}"
            umount $SYSDIR

            if which e2fsck &> /dev/null; then
                echo -e "${yellow}Check/repair file system.img${no}"
                e2fsck -f $SYSIMG -y
            fi

            if which resize2fs &> /dev/null; then
                # kecilkan partisi biar ga lama bgt ngeflashnya
                echo -e "${yellow}Minimizing system.img${no}"
                resize2fs -M $SYSIMG
            fi

            echo -e "${yellow}Modified system saved to mod folder${no}"
            echo -e "${green}Done, press any key to close${no}"
            read -n 1 
            ;;


        "Unlock Bootloader")
            UPDATEBIN="./tools/linux/update"
            echo -e "${yellow}Make sure you read readme.md in u-boot-lock folder${no}"
            echo -e "${red}Don't forget insert microsd with bootloader file${no}"
            $UPDATEBIN scan | grep 'No ' && exit 1
            $UPDATEBIN partition bootloader u-boot-lock/u-boot.bin
            ;;
        
        "Flash")
            UPDATEBIN="./tools/linux/update"
            $UPDATEBIN scan | grep 'No ' && exit 1
            clear
            echo -e "${red}FLASHING... DON'T UNPLUG YOUR STB${no}"
            [ -e flash/u-boot.bin ] && $UPDATEBIN partition bootloader flash/bootloader.img
            [ -e flash/boot.img ] && $UPDATEBIN partition boot flash/boot.img
            [ -e flash/conf.img ] && $UPDATEBIN partition conf flash/conf.img
            [ -e flash/logo.img ] && $UPDATEBIN partition logo flash/logo.img
            [ -e flash/recovery.img ] && $UPDATEBIN partition recovery flash/recovery.img
            $UPDATEBIN partition system mod/system.img
            $UPDATEBIN bulkcmd "amlmmc erase data"
            $UPDATEBIN bulkcmd "amlmmc erase cache"
            $UPDATEBIN bulkcmd "setenv hdmimode 720p60hz"
            $UPDATEBIN bulkcmd "setenv -f EnableSelinux permissive"
            $UPDATEBIN bulkcmd "setenv firstboot 1"
            $UPDATEBIN bulkcmd "saveenv"
            echo -e "${green}Done, press any key to close${no}"
            read -n 1
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
