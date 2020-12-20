#! /system/bin/sh

echo "Hi... Cendrawasih here!!!" > /dev/console
insmod /system/lib/ddr_window_64.ko
ddr_window & > /data/ddr_window_log.txt
