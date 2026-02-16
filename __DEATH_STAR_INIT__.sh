## version 1
#!/bin/bash

# ==============================================================================
# __DEATH_STAR_INIT__
# THE IMPERIAL REORGANIZATION PROTOCOL
# ==============================================================================

# Setup Variables
BASE_DIR="$HOME/DeathStar"
CACHE_DIR="$BASE_DIR/__psycache__"
MIRROR_NAME="__MIRROR_1__"
CURRENT_SCRIPT=$(basename "$0")

# ------------------------------------------------------------------------------
# SCENE 1: THE ARRIVAL
# ------------------------------------------------------------------------------
clear
echo "..."
sleep 1
echo "[SOUND: Heavy mechanical breathing]"
sleep 2
echo "LORD VADER: 'Trooper, report.'"
sleep 1
echo ""
echo "STORM TROOPER (TK-421): 'Sir! We have located the Rebel base (your home directory).'"
echo "STORM TROOPER (TK-421): 'It is... chaotic. Unauthorized files everywhere.'"
echo ""
echo "LORD VADER: 'Begin the purge. Prepare the __PSYCACHE__ protocols.'"
echo "LORD VADER: 'We shall build a new station here.'"
echo ""
echo "----------------------------------------------------------------"
echo "INITIATING __DEATH_STAR_INIT__..."
echo "----------------------------------------------------------------"
echo ""

# ------------------------------------------------------------------------------
# SCENE 2: THE EXODUS (Primary Goal 1)
# ------------------------------------------------------------------------------
echo "STORM TROOPER (TK-421): 'Citizen, listen closely.'"
echo "STORM TROOPER (TK-421): 'I am authorized to seize all current assets in this sector.'"
echo "STORM TROOPER (TK-421): 'We are creating a containment unit called $MIRROR_NAME.'"
echo "STORM TROOPER (TK-421): 'We will move your current belongings there, then seal it inside the __PSYCACHE__.'"
echo ""
read -p "DO YOU COMPLY WITH IMPERIAL ORDER 66? (y/n): " confirm_move

if [[ "$confirm_move" != "y" ]]; then
    echo "LORD VADER: 'You have failed me for the last time.' [FORCE CHOKE - EXITING]"
    exit 1
fi

echo ""
echo ">> [SYSTEM]: CONSTRUCTING DEATH STAR INFRASTRUCTURE..."

# 1. Create the Death Star Base
mkdir -p "$BASE_DIR"
mkdir -p "$BASE_DIR/downloads"
mkdir -p "$BASE_DIR/storage"
mkdir -p "$CACHE_DIR"

echo ">> [SYSTEM]: SECTOR 'DeathStar' ESTABLISHED."

# 2. Create the Mirror and Move Files
# We must be careful not to move the DeathStar itself into the mirror
echo ">> [SYSTEM]: INITIATING MASS MIGRATION TO $MIRROR_NAME..."

mkdir -p "$HOME/$MIRROR_NAME"

# Move visible files, excluding DeathStar and the script itself
# Using find to avoid errors with moving the script while it runs
find "$HOME" -maxdepth 1 -not -name 'DeathStar' -not -name "$MIRROR_NAME" -not -name "$CURRENT_SCRIPT" -not -name ".*" -exec mv {} "$HOME/$MIRROR_NAME" \; 2>/dev/null

echo ">> [SYSTEM]: ASSETS SECURED IN $MIRROR_NAME."

# 3. Move Mirror into Cache
echo "STORM TROOPER (TK-421): 'Loading cargo into the containment hold...'"
mv "$HOME/$MIRROR_NAME" "$CACHE_DIR/"

echo ">> [SYSTEM]: $MIRROR_NAME RELOCATED TO $CACHE_DIR."
echo ">> [SYSTEM]: HOME DIRECTORY PURGED."

# ------------------------------------------------------------------------------
# SCENE 3: EXPANSION (The Paths)
# ------------------------------------------------------------------------------
echo ""
echo "LORD VADER: 'Impressive. The foundation is laid.'"
echo "LORD VADER: 'But the station is not yet fully operational.'"
echo ""
echo "STORM TROOPER (TK-421): 'My Lord asks how you wish to configure the new sectors.'"
echo "STORM TROOPER (TK-421): 'Choose your path, citizen.'"
echo ""
echo "   [1] PATH OF THE SITH (Developer)"
echo "       >> Adds: /holocron_code, /droid_factory (builds), /sith_library (libs)"
echo ""
echo "   [2] PATH OF THE MOFF (Administrator/Data)"
echo "       >> Adds: /imperial_records, /surveillance_logs, /detention_block"
echo ""
echo "   [3] PATH OF THE BOUNTY HUNTER (Tools/Media)"
echo "       >> Adds: /armory (tools), /cargo_hold (media), /carbonite_freezer (archives)"
echo ""
read -p "SELECT YOUR ALIGNMENT [1-3]: " path_choice

case $path_choice in
    1)
        echo "LORD VADER: 'Good. Let the hate flow through your code.'"
        mkdir -p "$BASE_DIR/holocron_code"
        mkdir -p "$BASE_DIR/droid_factory"
        mkdir -p "$BASE_DIR/sith_library"
        echo ">> [SYSTEM]: SITH ARCHITECTURE DEPLOYED."
        ;;
    2)
        echo "LORD VADER: 'Bring order to the galaxy.'"
        mkdir -p "$BASE_DIR/imperial_records"
        mkdir -p "$BASE_DIR/surveillance_logs"
        mkdir -p "$BASE_DIR/detention_block"
        echo ">> [SYSTEM]: ADMINISTRATIVE SECTORS DEPLOYED."
        ;;
    3)
        echo "LORD VADER: 'No disintegrations.'"
        mkdir -p "$BASE_DIR/armory"
        mkdir -p "$BASE_DIR/cargo_hold"
        mkdir -p "$BASE_DIR/carbonite_freezer"
        echo ">> [SYSTEM]: HUNTER UTILITIES DEPLOYED."
        ;;
    *)
        echo "STORM TROOPER (TK-421): 'That wasn't an option. Moving along.'"
        ;;
esac

# ------------------------------------------------------------------------------
# SCENE 4: FINAL CHECK
# ------------------------------------------------------------------------------
echo ""
echo "STORM TROOPER (TK-421): 'Operation complete, Lord Vader.'"
echo ""
echo "LORD VADER: 'The Death Star is ready.'"
echo "LORD VADER: 'Your files are safely frozen in: ~/DeathStar/__psycache__/$MIRROR_NAME'"
echo "LORD VADER: 'Do not make me destroy this station.'"
echo ""
echo "----------------------------------------------------------------"
echo "             * IMPERIAL MARCH PLAYS IN DISTANCE *"
echo "----------------------------------------------------------------"
ls -F "$BASE_DIR"
