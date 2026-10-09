SCRIPTS_DIR="../scripts"
MAP_DIR="../wowr.w3x"
WOWR_DIR="$MAP_DIR/wowr"
PJASS="$SCRIPTS_DIR/pjass"
COMMON_J="$MAP_DIR/Scripts/common.j"
COMMON_AI="$MAP_DIR/Scripts/common.ai"
BLIZZARD_J="../wc3/fk/Scripts/Blizzard.j"
"$PJASS" -v

for f in "$WOWR_DIR"/*.ai
do
   if [[ "$f" == *"/common.ai" ]]; then
      continue
   fi

   "$PJASS" "$COMMON_J" "$COMMON_AI" "$BLIZZARD_J" "$f"
done

for f in "$WOWR_DIR"/*.pld
do
   "$PJASS" "$COMMON_J" "$BLIZZARD_J" "$f" # "$COMMON_AI" is not available in preload scripts
done

for f in "$MAP_DIR"/*.j
do
   if [[ "$f" == *"/common.j" ]]; then
      continue
   fi

   "$PJASS" "$COMMON_J" "$BLIZZARD_J" "$f" # "$COMMON_AI" is not available in map script war3map.j
done

for f in "$WOWR_DIR"/*.fdf
do
   java -cp "$SCRIPTS_DIR/*" com.etheller.warsmash.fdfparser.Main "$f"
done
