#!/bin/bash

if mount | grep "$PWD/master" &> /dev/null; then
    echo "Already setuped!"
    read -n 1
    exit 1
fi

echo "master setup using tmpfs (For faster oprek)"
echo "All files on master will be deleted an restored from GIT INDEX! make sure you commit it."

sudo rm -rf ./master
mkdir ./master
sudo mount -t tmpfs none ./master
sudo git checkout -- master/
echo "Done"
read -n 1

