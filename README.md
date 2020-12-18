## <div align="center">CendrawasihTV</div>

### General Feature
| Apps \ Device  | V1 | V2 | Dev |
|---|----|----|-----|
| Autoboost |<div align="center"> ✓ |<div align="center"> ✓ |<div align="center"> ✓  |</div>
| VOD | <div align="center">✓ | <div align="center">✓ | <div align="center">✓  |
| IPTV | <div align="center">✓| <div align="center">✓ | <div align="center">✓ |
| Kodi | | <div align="center">✓ | <div align="center">✓ |
| Termux|  | | <div align="center">✓ |
|MicroG + Service|  | <div align="center">✓ | <div align="center">✓ |

_**Note:** All version works with all varian, but if you force flash V2/Dev build to V1 (1Gb RAM) it will make your device lag._

### Usage
* Linux User
	* Download modified file system in [release file](https://github.com/Manssizz/CendrawasihTV/releases/)
	* Connect your stb to PC with usb male to male 
	* Extract with command ```tar -xf Cendrawasih-*.tar.gz```
	* Move to Cendrawasih folder
	* Type ```./flash.sh``` 
	* In terminal you will see 2 option. **Unlock Bootloader** and **Flash**
		* If you have stb with bootloader lock, you can see [this](https://github.com/Manssizz/CendrawasihTV/tree/master/u-boot-lock) reference before choose Unlock Bootloader
		* If you bootlaoder unlocked, you can choose flash menu.
		* You will see flashing process.
	***

* Windows User
	* Download modified file system in [release file](https://github.com/Manssizz/CendrawasihTV/releases/)
	* Connect your stb to PC with usb male to male 
	* Extract with archive software like winrar.
	* Move to Cendrawasih folder
	* Copy all .img file in ROM folder to tools/windows/ for easy flashing
	* If you bootlader locked, you must burn u-boot-sd.bin to your Microsd with BootCard Maker in _tools/windows/burnBootCard/_ folder
	* Press shift and Open Command Window Here (if you dont know about open command window here, right click and open as Adminstartion in _tools/windows/cmd-here-windows-10.reg_. it will auto set registry on your windows machine)
	* Type this command in cmd
		``` 
		update partition bootloader bootloader.img
		update partition boot boot.img
		update partition logo logo.img
		update partition system system.img
		update bulkcmd "amlmmc erase data"
		update bulkcmd "amlmmc erase cache"
		update bulkcmd "setenv hdmimode 720p60hz"
		update bulkcmd "setenv -f EnableSelinux permissive"
		update bulkcmd "setenv firstboot 1"
		update bulkcmd "saveenv"
		update “reset”	
		```
	* You will see flashing process.
	***

_<div align="right">Note: Best perform this project if you use Linux</div>_

### Contribute
Feel free if you want to contribute with this project.

### Credits
- [ndunks](https://github.com/ndunks/custom-rom-stb-zte-B860-indihome) for original ROM
- [jerryn70](https://github.com/jerryn70/GoodbyeAds) for GoodbyeAds host list