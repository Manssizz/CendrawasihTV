#!/bin/bash
SYSDIR="mod/system"
SYSIMG="mod/system.img"
red='\033[31m'
no='\033[0m'
yellow='\e[33m'
blue='\e[34m'
green='\e[32m'

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
            rm $SYSIMG
            clear
            
            echo -e "${green}Copy original firmware...${no}"
            cp -v original/v1/system.img $SYSIMG || exit 1
            chmod 777 $SYSIMG


            echo -e "${yellow}Mounting system.img to $SYSDIR ${no}"
            [ -d $SYSDIR ] || mkdir $SYSDIR
            mount -o loop,noatime,rw,sync $SYSIMG $SYSDIR

            #Modding Script
            echo -e "${red}Remove 3rd Apps (indihome) ${no}"
            rm -rf $SYSDIR/preinstall

            echo -e "${red}Remove Unwanted Apps${no}"
            # Must be removed, or you got Iptv Err
            rm -f $SYSDIR/app/MainControl.apk
            rm -f $SYSDIR/app/sqm.apk
            rm -rf $SYSDIR/app/apk

            rm -f $SYSDIR/app/AppsMgr-release.apk
            rm -f $SYSDIR/app/ajvm.apk
            rm -f $SYSDIR/app/AptoideTV-3.3.1-useeapps.apk
            rm -f $SYSDIR/app/FactoryTestTool.apk
            rm -f $SYSDIR/app/iptvclient_boot-release.apk
            rm -f $SYSDIR/app/popup-release-signed.apk
            rm -f $SYSDIR/app/ZTEUpgrade.apk
            rm -f $SYSDIR/app/ZTEBrowser.apk
            rm -f $SYSDIR/app/ZTEPlayer.apk

            rm -f $SYSDIR/app/VideoTestTool.apk
            rm -rf $SYSDIR/app/QuickSearchBox
            rm -rf $SYSDIR/app/NetworkTest
            rm -rf $SYSDIR/app/ztehelper
            rm -rf $SYSDIR/app/HomeMediaCenter

            rm -f $SYSDIR/app/IPTV.apk
            rm -f $SYSDIR/app/mcspbase.apk
            rm -f $SYSDIR/app/NaAgent.apk
            rm -f $SYSDIR/app/netmanager.apk
            rm -f $SYSDIR/app/nmAssistant.apk

            # Cleann!
            rm -f $SYSDIR/app/OSDService.apk
            rm -f $SYSDIR/app/ZeroCfgUI.apk
            rm -f $SYSDIR/app/Dlnagwapt.apk
            rm -f $SYSDIR/app/MSGAPK.apk

            rm -f $SYSDIR/app/dlna.apk
            rm -f $SYSDIR/app/MSGAPKSub.apk
            rm -rf $SYSDIR/app/AuthConfig
            rm -rf $SYSDIR/app/SubtitleService
            rm -rf $SYSDIR/app/FileBrowser

            # MeBox launcher
            rm -f $SYSDIR/app/launcher_tkz4.apk

            # Must removed if using GAPPS TV
            rm -f $SYSDIR/app/TVClient.apk
            #rm -rf $SYSDIR/app/ADBSetting
            rm -rf $SYSDIR/app/Camera2
            rm -rf $SYSDIR/app/Music
            rm -rf $SYSDIR/app/DownloadProviderUi
            rm -f $SYSDIR/app/com.google.android.tts-3.10.10-210310101.apk
            rm -rf $SYSDIR/priv-app/Contacts/
            rm -rf $SYSDIR/priv-app/LiveTv/

            #Uncomment if you want use hardware keyboard only (no softkeyboard)
            #rm -rf $SYSDIR/app/LatinIME
            #rm -rf $SYSDIR/app/OpenWnn

            echo -e "${red}Remove Unwanted services${no}"
            rm -f $SYSDIR/bin/netaccess
            rm -f $SYSDIR/bin/depconfig
            rm -rf $SYSDIR/app/AppInstaller
            rm -rf $SYSDIR/priv-app/Gallery2/

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
            
            
            echo 'Merge rootfs/* into $SYSDIR/*'
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
            SYSDIR="mod/system"
            SYSIMG="mod/system.img"

            cp -v original/v2/system.img $SYSIMG || exit 1
            chmod 777 $SYSIMG


            echo "Mounting system.img to $SYSDIR"
            [ -d $SYSDIR ] || mkdir $SYSDIR
            mount -o loop,noatime,rw,sync $SYSIMG $SYSDIR

            #Modding Script
            echo "Remove 3rd Party Apps (indihome)"
            rm -rf $SYSDIR/preinstall
            
            echo "Remove Unwanted Apps"
            # Must be removed, or you got Iptv Err
            rm -f $SYSDIR/app/MainControl.apk
            rm -f $SYSDIR/app/sqm.apk
            rm -rf $SYSDIR/app/apk

            rm -f $SYSDIR/app/AppsMgr-release.apk
            rm -f $SYSDIR/app/ajvm.apk
            rm -f $SYSDIR/app/AptoideTV-3.3.1-useeapps.apk
            rm -f $SYSDIR/app/FactoryTestTool.apk
            rm -f $SYSDIR/app/iptvclient_boot-release.apk
            rm -f $SYSDIR/app/popup-release-signed.apk
            rm -f $SYSDIR/app/ZTEUpgrade.apk
            rm -f $SYSDIR/app/ZTEBrowser.apk
            rm -f $SYSDIR/app/ZTEPlayer.apk

            rm -f $SYSDIR/app/VideoTestTool.apk
            rm -rf $SYSDIR/app/QuickSearchBox
            rm -rf $SYSDIR/app/NetworkTest
            rm -rf $SYSDIR/app/ztehelper
            rm -rf $SYSDIR/app/HomeMediaCenter

            rm -f $SYSDIR/app/IPTV.apk
            rm -f $SYSDIR/app/mcspbase.apk
            rm -f $SYSDIR/app/NaAgent.apk
            rm -f $SYSDIR/app/netmanager.apk
            rm -f $SYSDIR/app/nmAssistant.apk

            # Cleann!
            rm -f $SYSDIR/app/OSDService.apk
            rm -f $SYSDIR/app/ZeroCfgUI.apk
            rm -f $SYSDIR/app/Dlnagwapt.apk
            rm -f $SYSDIR/app/MSGAPK.apk

            rm -f $SYSDIR/app/dlna.apk
            rm -f $SYSDIR/app/MSGAPKSub.apk
            rm -rf $SYSDIR/app/AuthConfig
            rm -rf $SYSDIR/app/SubtitleService
            rm -rf $SYSDIR/app/FileBrowser

            # MeBox launcher
            rm -f $SYSDIR/app/launcher_tkz4.apk

            # Must removed if using GAPPS TV
            rm -f $SYSDIR/app/TVClient.apk
            #rm -rf $SYSDIR/app/ADBSetting
            rm -rf $SYSDIR/app/Camera2
            rm -rf $SYSDIR/app/Music
            rm -rf $SYSDIR/app/DownloadProviderUi
            rm -f $SYSDIR/app/com.google.android.tts-3.10.10-210310101.apk
            rm -rf $SYSDIR/priv-app/Contacts/
            rm -rf $SYSDIR/priv-app/LiveTv/

            echo -e "${yellow}Remove extra packages${no}"
            rm -rf $SYSDIR/app/cleanXperience-v2
            rm -rf $SYSDIR/app/com.google.android.youtube.tv-1
            rm -rf $SYSDIR/app/GoogleJapaneseInput
            rm -rf $SYSDIR/app/PlayGamesPano
            rm -rf $SYSDIR/app/Mebox_1.1.3.58.apk
            rm -rf $SYSDIR/app/snowball.apk
            rm -rf $SYSDIR/app/Superuser.apk
            rm -rf $SYSDIR/app/Root_Exploler.apk
            rm -rf $SYSDIR/app/ATV_Launcher.apk
            rm -rf $SYSDIR/priv-app/OneTimeInitializer
            rm -rf $SYSDIR/priv-app/PackageInstaller
#            rm -rf $SYSDIR/priv-app/Phonesky
#            rm -rf $SYSDIR/priv-app/PrebuiltGmsCorePano



            echo "Remove Album"
            rm -rf $SYSDIR/priv-app/Gallery2/
            
            echo "Bootanimation"
            pushd master/bootanimation
            [ -e ../v2/media/bootanimation.zip ] && sudo rm ../v2/media/bootanimation.zip
            [ -d ../v2/media ] || mkdir ../v2/media
            sudo zip -0 -r '../v2/media/bootanimation.zip' *
            popd

            echo "Coying default data"
#            [ -d master/v1/data_default ] || mkdir -p master/v2/data_default/data
#             Fix data permissions, its changed after checkout from git
#            chmod -R og+rw master/v2/data_default/data/*
            chmod -R +x master/v1/xbin/*
            chmod -R +x master/v1/bin/*

            echo 'Merge mod folder into $SYSDIR/*'
            cp -pruv master/v1/* $SYSDIR/
            cp -pruv master/v2/* $SYSDIR/
            #cp -pruv gapps_beta/rootfs_gapps/* $SYSDIR/
            unzip -o master/fonts.zip -d $SYSDIR/fonts/
            #rm master/v2/app/klampok.apk

            echo "Unmount $SYSDIR"
            umount $SYSDIR

            if which e2fsck &> /dev/null; then
                echo "Check/repair file system.img"
                e2fsck -f $SYSIMG -y
            fi

            if which resize2fs &> /dev/null; then
                # kecilkan partisi biar ga lama bgt ngeflashnya
                echo "Minimizing system.img"
                resize2fs -M $SYSIMG
            fi

	    	echo -e "${yellow}Modified system saved to mod folder${no}"
            echo -e "${green}Done, press any key to close${no}"
            read -n 1
            ;;
        "Developer Build")
            echo "you chose choice $REPLY which is $opt"
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
            #[ -e release/u-boot.bin ] && $UPDATEBIN partition bootloader release/u-boot.bin
            [ -e release/boot.img ] && $UPDATEBIN partition boot release/boot.img
            [ -e release/conf.img ] && $UPDATEBIN partition conf release/conf.img
            #[ -e release/logo.img ] && $UPDATEBIN partition logo kitchen/logo.img
            [ -e release/env.img ] && $UPDATEBIN partition env release/env.img
            [ -e release/recovery.img ] && $UPDATEBIN partition recovery release/recovery.img
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
