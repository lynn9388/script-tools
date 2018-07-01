#!/bin/bash

# Launch rslsync if it's not running
ps -A | grep rslsync
if [ $(ps -A | grep -c rslsync) -ne 1 ]; then
    cd ~/Documents/Sync/
    sudo ./rslsync
fi

# Compress every virtual machine folder
TarVM() {
    for subfolder in "$1"/*
    do
        folderName=$(basename "$subfolder")
        if [ "$folderName" = "Shared VMs" ]; then
            TarSubfolder "$1"/Shared\ VMs "$2"/Shared\ VMs
        else
            sudo tar -cvpf "$2"/"$folderName".tar "$subfolder"
        fi
    done
}

DIR=~/Backup/$(date +"%Y-%m-%d_%H%M%S")
mkdir -p "$DIR"/Shared\ VMs
TarVM ~/vmware/ "$DIR"
