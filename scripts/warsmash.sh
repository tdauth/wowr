#!/bin/bash
DIR=$(pwd)
INI_FILE="$DIR/warsmash.ini"
#MAP_DIR=../wowr.w3x # https://github.com/Retera/WarsmashModEngine/issues/97
MAP_DIR="$DIR/../releases/wowr4.6.w3x"
WARSMASH_DIR="$HOME/Dokumente/Projekte/WarsmashModEngine"
cd "$WARSMASH_DIR"
git pull
#./gradlew clean
./gradlew :desktop:runGame -Pargs="-loadfile $MAP_DIR -ini $INI_FILE -window"
echo "See Warsmash logs in $(pwd)/core/assets/Logs"
