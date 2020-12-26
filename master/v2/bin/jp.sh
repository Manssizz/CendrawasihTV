#!/system/bin/sh

# For tracing purposes
echo "Modules Launcher boot trace" > /sdcard/joypad/joypad.log
echo "====================================" >> /sdcard/joypad/joypad.log
echo "USB devices detected" >> /sdcard/joypad/joypad.log
echo "====================================" >> /sdcard/joypad/joypad.log
lsusb >>  /sdcard/joypad/joypad.log
echo "====================================" >> /sdcard/joypad/joypad.log
echo "Modules" >> /sdcard/joypad/joypad.log
echo "= Before ===========================" >> /sdcard/joypad/joypad.log
lsmod >> /sdcard/joypad/joypad.log

# Modules here ===========================================>

# Xbox gamepads
insmod /system/lib/jp/ff-memless.ko
insmod /system/lib/jp/xpad.ko
insmod /system/lib/jp/hid-microsoft.ko

# Logitech HID drivers
insmod /system/lib/jp/hid-logitech.ko
insmod /system/lib/jp/hid-logitech-dj.ko

# Sony gamepads
insmod /system/lib/jp/hid-sony.ko
insmod /system/lib/jp/hid-sony2.ko
insmod /system/lib/jp/hid-ps3remote.ko

# Other drivers
insmod /system/lib/jp/a3d.ko
insmod /system/lib/jp/adi.ko
insmod /system/lib/jp/analog.ko
insmod /system/lib/jp/ansi_cprng.ko
insmod /system/lib/jp/as5011.ko
insmod /system/lib/jp/cobra.ko
insmod /system/lib/jp/hid-dr.ko
insmod /system/lib/jp/hid-pl.ko
insmod /system/lib/jp/hid-samsung.ko
insmod /system/lib/jp/hid-tmff.ko
insmod /system/lib/jp/iforce.ko
insmod /system/lib/jp/interact.ko
insmod /system/lib/jp/joydev.ko
insmod /system/lib/jp/joydump.ko
insmod /system/lib/jp/lcd.ko
insmod /system/lib/jp/magellan.ko
insmod /system/lib/jp/rng-core.ko
insmod /system/lib/jp/sidewinder.ko
insmod /system/lib/jp/spaceball.ko
insmod /system/lib/jp/spaceorb.ko
insmod /system/lib/jp/stinger.ko
insmod /system/lib/jp/tmdc.ko
insmod /system/lib/jp/twidjoy.ko
insmod /system/lib/jp/warrior.ko
insmod /system/lib/jp/zhenhua.ko

# <=======================================================
# For tracing purposes
echo "= After ============================" >> /sdcard/joypad/joypad.log
lsmod >> /sdcard/joypad/joypad.log
echo "= END ==============================" >> /sdcard/joypad/joypad.log