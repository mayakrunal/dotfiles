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

copy_file() {
    SOURCE=$1
    DEST=$2
    if [ -f "$SOURCE" ]; then
        mkdir -p "$DEST"
        echo "COPYING SOURCE:$SOURCE , TO DEST: $DEST "
        cp -a "$SOURCE" "$DEST"
    else
        echo "SOURCE: $SOURCE DOES NOT EXISTS"
    fi
}

# config folders
config=("/awesome"
    "/alacritty"
    "/conky"
    "/jgmenu"
    "/lf"
    #   "/nvim"
    "/qtile"
    "/picom"
    "/rofi")

for FOLDER in "${config[@]}"; do

    SOURCE=$HOME_DIR$CONFIG_FOLDER$FOLDER
    DEST=$GIT_DIR$CONFIG_FOLDER$FOLDER
    copy_folder "$SOURCE" "$DEST"
done

#profile files
profiles=(
    "/.bash_profile"
    "/.bashrc"
    "/.vimrc"
    "/.zshrc"
    "/.xprofile")

for FILE in "${profiles[@]}"; do

    SOURCE=$HOME_DIR$FILE
    DEST=$GIT_DIR
    copy_file "$SOURCE" "$DEST"
done

echo "DONE."
