@echo off
setlocal enabledelayedexpansion

echo ================================================
echo  Half Sword / Steam Windows Container Setup
echo ================================================
echo.
echo This script runs automatically after Windows is installed.
echo It prepares the environment for Steam + Half Sword.
echo.

:: Basic perf / gaming friendly tweaks (safe ones)
echo Applying some performance tweaks...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

:: Create a convenient desktop shortcut folder
if not exist "C:\Users\%USERNAME%\Desktop\Gaming Setup" mkdir "C:\Users\%USERNAME%\Desktop\Gaming Setup"

:: Download latest Steam installer to Desktop (user will run it)
echo Downloading Steam installer...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "try { Invoke-WebRequest -Uri 'https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe' -OutFile 'C:\Users\%USERNAME%\Desktop\SteamSetup.exe' -UseBasicParsing } catch { Write-Host 'Download failed, you can manually download from https://store.steampowered.com/about/' }"

:: Also put a copy in the Gaming Setup folder
copy "C:\Users\%USERNAME%\Desktop\SteamSetup.exe" "C:\Users\%USERNAME%\Desktop\Gaming Setup\" >nul 2>&1

:: Optional: Download a couple of common Visual C++ runtimes that many games (including Unreal-based ones like Half Sword) need.
:: Steam usually installs these, but pre-staging helps.
echo Downloading common game runtimes (Visual C++ Redistributables)...
mkdir "C:\OEM\runtimes" 2>nul

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$runtimes = @( 'https://aka.ms/vs/17/release/vc_redist.x64.exe', 'https://aka.ms/vs/17/release/vc_redist.x86.exe' ); foreach ($url in $runtimes) { $name = Split-Path $url -Leaf; try { Invoke-WebRequest -Uri $url -OutFile \"C:\OEM\runtimes\$name\" -UseBasicParsing } catch {} }"

echo.
echo ================================================
echo  NEXT STEPS (do these inside Windows):
echo ================================================
echo  1. Open the "SteamSetup.exe" on your Desktop and install Steam.
echo  2. Log into your Steam account.
echo  3. Install "Half Sword" (search in your library or store).
echo     - Note: Half Sword has good Proton reports; on native Windows it should run great.
echo  4. (Recommended for playing from your Mac) Install a streaming tool INSIDE this Windows:
echo     - Parsec (easy, great macOS client): https://parsec.app/downloads
echo     - OR Sunshine (free, pairs with Moonlight client on your Mac): https://github.com/LizardByte/Sunshine
echo  5. For best experience with physics/combat games, use a low-latency connection (wired host, good WiFi, low latency to container host).
echo.
echo  Shared folder on host is mounted at C:\Shared (or "Shared" on desktop).
echo.
echo Setup script complete. You can close this window.
echo ================================================

:: Keep window open a bit so user sees it if they are watching
timeout /t 15 >nul

endlocal
