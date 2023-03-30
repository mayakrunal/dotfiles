#!/bin/bash

HOME_DIR=$HOME
GIT_DIR=$(pwd)
CONFIG_FOLDER="/.config"
echo "HOME DIR:$HOME_DIR"
echo "GIT DIR:$GIT_DIR"

# copy function
copy_folder() {
    SOURCE=$1
    DEST=$2
    if [ -d "$SOURCE" ]; then
        echo "MAKE SURE DESTDIR EXISTS"
        mkdir -p "$DEST"
        echo "COPYING SOURCE:$SOURCE , TO DEST: $DEST "
        cp -a "$SOURCE/." "$DEST"
    else
        echo "SOURCEDIR: $SOURCE DOES NOT EXISTS"
    fi

}

# config folders
config=("/awesome"
    "/alacritty"
    "/conky"
    "/jgmenu"
    "/lf"
    "/nvim"
    "/picom"
    "/rofi")

for FOLDER in "${config[@]}"; do

    SOURCE=$HOME_DIR$CONFIG_FOLDER$FOLDER
    DEST=$GIT_DIR$CONFIG_FOLDER$FOLDER
    copy_folder "$SOURCE" "$DEST"
done
