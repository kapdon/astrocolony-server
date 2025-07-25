# 🚧🚧🚧 "works-for-me" – TESTING NEEDED! 🚧🚧🚧

> **This project is under active development and real-world testing is encouraged.**
>
> **Please report any issues, pull requests, or improvements!**
>
> **DO NOT USE IN PRODUCTION YET.**  
> Community feedback and bug reports are highly appreciated!


# Astro Colony Dedicated Server (Docker)

A flexible, production-ready Docker solution for running the official Astro Colony Dedicated Server on Linux.  
- **Automated updates** via SteamCMD
- **Dynamic configuration** using Docker environment variables
- **Proper user mapping** for clean file permissions
- **Persisted data** on the host
- **Supports Steam branch selection and custom arguments**



## Features

- Dynamic `ServerSettings.ini` using all environment variables prefixed with `AC_`
- Change the public server name with `SteamServerName` env (not written to ini)
- Supports experimental/public Steam branches (`UPDATE_BRANCH`)
- Runs as your host user (`PUID`/`PGID`)
- All game data stored in `./data` for persistence


## Example: Docker Compose Setup

To get started quickly, copy the provided example file:

```sh
cp compose.yml.example compose.yml
```

Edit `compose.yml` to fit your needs (change ports, volumes, environment variables, etc).

**Example `compose.yml.example`:**

```yaml
services:
  astrocolony-server:
    build: .
    container_name: astrocolony-dedicated
    environment:
      # Docker-level user and SteamCMD settings
      PUID: "1000"
      PGID: "1000"
      APP_ID: "2934900"
      UPDATE_BRANCH: "public"

      # Visible Steam name (not written to ini)
      SteamServerName: "My Awesome Colony"

      # Astro Colony server config (AC_ prefix for dynamic config)
      AC_ServerPassword: "YourPassword"
      AC_Seed: "113"
      AC_MapName: "YourMapName"
      AC_MaxPlayers: "5"
      AC_ShouldLoadLatestSavegame: "True"
      AC_AdminList: "76561199104220463"
      AC_SharedTechnologies: "True"
      AC_OxygenConsumption: "True"
      AC_AutosaveInterval: "5.0"
      AC_AutosavesCount: "10"
      AC_FreeConstruction: "True"
      AC_Sandbox: "True"
    volumes:
      - ./data:/home/steam/astro_server
    ports:
      - "7777:7777/udp"
      - "27015:27015/udp"
    restart: unless-stopped
```

> **Tip:**  
> All environment variables prefixed with `AC_` will be written to `ServerSettings.ini`.  
> Adjust `PUID` and `PGID` to match your host user for correct file permissions.


