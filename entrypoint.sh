#!/bin/bash
set -e

export SERVERDIR="/home/steam/astro_server"
export APP_ID="${APP_ID:-2934900}"
export PUID="${PUID:-1000}"
export PGID="${PGID:-1000}"
export UPDATE_BRANCH="${UPDATE_BRANCH:-public}"

# If running as root, fix user/group ids and permissions, then exec as steam user
if [ "$(id -u)" = "0" ]; then
    groupmod -o -g "$PGID" steam || true
    usermod  -o -u "$PUID" -g "$PGID" steam || true
    chown -R steam:steam /home/steam
    exec gosu steam "$0" "$@"
fi

STEAMCMD="/home/steam/steamcmd/steamcmd.sh"

# 1. Install/update server
if [ "$UPDATE_BRANCH" = "public" ]; then
  $STEAMCMD \
    +force_install_dir "$SERVERDIR" \
    +login anonymous \
    +app_update "$APP_ID" validate \
    +quit
else
  $STEAMCMD \
    +force_install_dir "$SERVERDIR" \
    +login anonymous \
    +app_update "$APP_ID" -beta "$UPDATE_BRANCH" validate \
    +quit
fi

# 2. Dynamic ServerSettings.ini from env vars (AC_* → key=value)
CONFIG_PATH="${SERVERDIR}/AstroColony/Saved/Config/LinuxServer"
mkdir -p "$CONFIG_PATH"

echo "[/Script/ACFeature.EHServerSubsystem]" > "${CONFIG_PATH}/ServerSettings.ini"

env | grep '^AC_' | while IFS='=' read -r var val
do
    key="${var#AC_}"
    echo "${key}=${val}" >> "${CONFIG_PATH}/ServerSettings.ini"
done

echo "==== ServerSettings.ini ===="
cat "${CONFIG_PATH}/ServerSettings.ini"
echo "==========================="

echo "Listing server directory:"
ls -lR "$SERVERDIR"

# 3. Start server via provided shell script with -SteamServerName and -log
cd "$SERVERDIR"
chmod +x ./AstroColonyServer.sh
exec ./AstroColonyServer.sh -SteamServerName="${SteamServerName:-AstroColony}" -log
