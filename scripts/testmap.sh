#!/bin/bash
sudo snap connect steam:network-manager

export STEAM_DIR="$HOME/snap/steam/common/.local/share/Steam"
protontricks -l

APP_ID="2243394608"

protontricks "$APP_ID" dxvk

DRIVE_C="$STEAM_DIR/steamapps/compatdata/$APP_ID/pfx/drive_c"
WC3="$DRIVE_C/Program Files (x86)/Warcraft III/_retail_/x86_64/Warcraft III.exe"
WC3_PTR="$DRIVE_C/Program Files (x86)/Warcraft III/_ptr_/x86_64/Warcraft III.exe"

MAP_NAME="wowr4.7.w3x"
MAP="$HOME/Dokumente/Projekte/wowr/releases/$MAP_NAME"
MAPS_DIR="$DRIVE_C/users/steamuser/Documents/Warcraft III/Maps/"
mkdir -p "$MAPS_DIR"
cp "$MAP" "$MAPS_DIR"

INTERNAL_MAP_PATH="C:\users\steamuser\Documents\Warcraft III\Maps\\$MAP_NAME"

echo "$WC3"

# Pfad zum Agent (bitte prüfen, ob der Ordner existiert)
AGENT="$DRIVE_C/Program Files (x86)/Battle.net/Agent/Agent.exe"

# Startet den Agent im Hintergrund
protontricks -c "wine \"$AGENT\"" "$APP_ID" &
sleep 5 # Kurze Pause, damit der Agent hochfahren kann

#protontricks -c "wine \"$WC3_PTR\" -launch -fl-no-login -no-auth -window -windowmode windowed -locale deDE -nowebcache -no-browser -graphicsapi Direct3D11 -loadmap \"$INTERNAL_MAP_PATH\"" "$APP_ID"
protontricks -c "wine \"$WC3_PTR\" -launch -fl-no-login -no-auth -window -windowmode windowed -locale deDE -nowebcache -no-browser -graphicsapi Direct3D11" "$APP_ID"
