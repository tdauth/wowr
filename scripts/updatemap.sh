#!/bin/bash
VERSION="4.7"
FILE="wowr$VERSION.w3x"
SOURCE="$HOME/snap/steam/common/.local/share/Steam/steamapps/compatdata/2424345529/pfx/drive_c/users/steamuser/Documents/Warcraft III/Maps/$FILE"
RELEASES_FOLDER="$HOME/Dokumente/Projekte/wowr/releases"
TARGET_FOLDER_0="$HOME/snap/steam/common/.local/share/Steam/steamapps/compatdata/2243394608/pfx/drive_c/users/steamuser/Documents/Warcraft III/Maps/wowr"
TARGET_FOLDER_1="$HOME/snap/steam/common/.local/share/Steam/steamapps/compatdata/3557148830/pfx/drive_c/users/steamuser/Documents/Warcraft III/Maps/wowr"

cp "$SOURCE" "$RELEASES_FOLDER"
cp "$SOURCE" "$TARGET_FOLDER_0"
cp "$SOURCE" "$TARGET_FOLDER_1"
