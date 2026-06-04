# Best Free & Open Source Way to Play Half Sword Locally on Your M1 Max

Since you don't like the full Windows emulation (slow on Apple Silicon for games), here's the **practical free OSS path**:

Use **UTM** (free, open source) to run a lightweight **Linux VM**, then install Steam + Proton inside it. Half Sword has good Proton reports and runs via Proton on Linux/Steam Deck.

This avoids Windows entirely, uses native Linux gaming stack, and is 100% free/open source. Performance will be much better than emulating Windows for this game.

## Why This Over Windows Emulation?
- Full Windows (via QEMU/UTM or Docker) on M1 Max has poor/no hardware GPU acceleration for DirectX games → slow for Half Sword.
- Linux + Proton translates the Windows game to run well on Apple Silicon via Vulkan/Metal.
- UTM is free OSS QEMU with good Apple Silicon support.
- No paid software, no cloud streaming.

## Setup Steps

1. **Install UTM** (free from GitHub/website, not the paid App Store version):
   - https://mac.getutm.app/
   - Download the .dmg, open it, drag UTM to Applications.

2. **Create a Linux VM in UTM** (Debian or Ubuntu recommended for simplicity):
   - Open UTM → Click + to create new VM.
   - Choose "Virtualize" (better perf on Apple Silicon) → Linux.
   - Download a recent Ubuntu or Debian ISO (or let UTM help).
     - Recommended: Ubuntu Desktop 24.04 LTS ARM64 from https://ubuntu.com/download/desktop (or use the ISO downloader in UTM).
   - Allocate resources:
     - RAM: 8-16 GB (you have 64 GB total, plenty left for macOS).
     - CPU cores: 4-6.
     - Storage: 64 GB+ (dynamic).
   - Enable "Share directory" and point it to `~/HalfSword-Shared` (we already created this folder for you).
   - Finish and start the VM. Install Linux normally (create a user account).

3. **Inside the Linux VM - Install Steam + Proton**:
   - Open terminal in Linux.
   - Update system:
     ```bash
     sudo apt update && sudo apt upgrade -y
     ```
   - Install Steam (official):
     ```bash
     sudo apt install steam -y
     ```
     Or download .deb from store.steampowered.com and install.
   - Launch Steam, log in with your account.
   - In Steam Settings → Steam Play:
     - Enable "Enable Steam Play for all other titles".
     - Choose Proton Experimental or latest Proton (e.g. Proton 9 or 10).
   - Search for Half Sword in your library (or install via Steam).
   - Install and play. It should use Proton automatically.

4. **File Sharing**:
   - The `~/HalfSword-Shared` folder on your Mac will be shared into the VM (mount it in Linux if not automatic).
   - Use it for game files, mods, etc.

5. **Performance Tips**:
   - In UTM VM settings (shut down first): Give more cores/RAM if needed.
   - In game: Start on medium/low settings. Half Sword is physics-heavy; Linux Proton often handles it better than emulated Windows.
   - For better input: Use UTM's SPICE tools or enable "Tablet" input mode.
   - If performance is still not great, the game runs via Proton on real Linux hardware well (per ProtonDB).

## Alternative: Steam Headless in Docker (if you prefer containers)
We have `docker-compose.steam-headless.yml` in this folder.
- This runs a Linux container with Steam + Proton + Sunshine (for streaming the game back to your Mac if desired).
- Requires Docker Desktop running.
- Edit the file for your PUID/PGID and passwords.
- Then: `docker compose -f docker-compose.steam-headless.yml up -d`
- Access via web UI or Moonlight client.
- **Caveat for macOS/Apple Silicon**: The upstream image is amd64-only, so it runs emulated (Rosetta) in Docker. GPU/3D performance for games will be very limited. The UTM native Linux VM path is strongly preferred on Mac.

Run the helper for status:
```bash
bash setup-parallels-env.sh
```

## If You Change Your Mind
- Cloud: GeForce NOW (easiest, but streaming).
- Paid but excellent: CrossOver or Parallels.

All local options here are free and open source (UTM, Proton, dockur if you want Windows anyway).

Let me know the next step or what specifically you didn't like about the previous setups! We can refine. 

Your M1 Max 64GB can handle a nicely allocated Linux VM easily.