#!/system/bin/sh

function Path_replace()
{
	#sed -e s:logo_1280x720:$src_720:g -e s:logo_1920x1080:$src_1080:g /system/etc/material.conf > /tmp/material.conf
	cp /system/etc/material.conf /tmp/material.conf
	if [ ! -f /tmp/material.conf ]
	then
	    return -1
	fi
}

function Logo_make()
{
	echo "debug"
	Path_replace

	${MKLOGO} /tmp/material.conf /tmp/logo.bin
	if [ ! -f /tmp/logo.bin ]
	then
		 return -2
	fi

	${MKIMG} /tmp/logo.bin ${dest} \
		${name} ${version} \
		1 \
		1 \
		1
	if [ ! -f "${dest}" ]
	then
		return -3
	fi
	rm -rf /tmp/material.conf
	rm -rf /tmp/logo.bin
}
name=jpeg
#name=$1
MKLOGO=mklogo
MKIMG=mkimg

#version=V713002
version=$1
src_720=$2
src_1080=$3
dest=$4
Logo_make
echo "finish!"	

