# This second option relies on you're terminal using the catppuccin theme and well use true catppuccin colors:
set BLK 03 
set CHR 03 
set DIR 04 
set EXE 02 
set REG 07 
set HARDLINK 05 
set SYMLINK 05 
set MISSING 08 
set ORPHAN 05 
set FIFO 06 
set SOCK 03 
set UNKNOWN 01

# Export Context Colors
set -Ux NNN_COLORS "#04020301;4231"

# Finally Export the set file colors ( Both options require this)
set -Ux NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$UNKNOWN"
