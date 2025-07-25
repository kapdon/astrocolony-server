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


