#!/bin/bash
red='\033[31m'
no='\033[0m'
yellow='\e[33m'
blue='\e[34m'
green='\e[32m'
UPDATEBIN="../tools/linux/update"

[ "$UID" = "0" ] || exec sudo "$0" "$@"
echo -e "+--------------------------------------------+"
echo -e "              ${red}CendrawasihTV${no}                   "
echo -e "      github.com/manssizz/CendrawasihTV       "
echo -e "        ${yellow}Don't forget to read BUILD.MD${no}         "
echo -e "+--------------------------------------------+"


PS3='Select your device: '
options=("ZTE B860H v1" "ZTE B860H v2" "Developer Build" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "ZTE B860H v1")
			$UPDATEBIN scan | grep 'No ' && exit 1
			echo -e "${red}FLASHING... DON'T UNPLUG YOUR STB!${no}"
			[ -e boot.img ] && $UPDATEBIN partition boot boot.img
			[ -e conf.img ] && $UPDATEBIN partition conf conf.img
			[ -e env.img ] && $UPDATEBIN partition env env.img
			[ -e recovery.img ] && $UPDATEBIN partition recovery recovery.img
			$UPDATEBIN partition system v1/system.img
			$UPDATEBIN bulkcmd "amlmmc erase data"
			$UPDATEBIN bulkcmd "amlmmc erase cache"
			$UPDATEBIN bulkcmd "setenv hdmimode 720p60hz"
			$UPDATEBIN bulkcmd "setenv -f EnableSelinux permissive"
			$UPDATEBIN bulkcmd "setenv firstboot 1"
			$UPDATEBIN bulkcmd "saveenv"
			echo -e "${green}Done, press any key to close${no}"
			read -n 1
			;;
        "ZTE B860H v2")
			$UPDATEBIN scan | grep 'No ' && exit 1
			echo -e "${red}FLASHING... DON'T UNPLUG YOUR STB!${no}"
			[ -e boot.img ] && $UPDATEBIN partition boot boot.img
			[ -e conf.img ] && $UPDATEBIN partition conf conf.img
			[ -e env.img ] && $UPDATEBIN partition env env.img
			[ -e recovery.img ] && $UPDATEBIN partition recovery recovery.img
			$UPDATEBIN partition system v2/system.img
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
