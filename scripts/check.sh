SCRIPTS_DIR="../scripts"
MAP_DIR="../wowr.w3x"
WOWR_DIR="$MAP_DIR/wowr"
PJASS="$SCRIPTS_DIR/pjass"
COMMON_J="$MAP_DIR/scripts/common.j"
COMMON_AI="$MAP_DIR/scripts/common.ai"
BLIZZARD_J="../wc3/reforged/scripts/blizzard.j"
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
   "$PJASS" "$COMMON_J" "$COMMON_AI" "$BLIZZARD_J" "$f"
done

for f in "$MAP_DIR"/*.j
do
   if [[ "$f" == *"/common.j" ]]; then
      continue
   fi

   "$PJASS" "$COMMON_J" "$COMMON_AI" "$BLIZZARD_J" "$f"
done

for f in "$WOWR_DIR"/*.fdf
do
   java -cp "$SCRIPTS_DIR/*" com.etheller.warsmash.fdfparser.Main "$f"
done
