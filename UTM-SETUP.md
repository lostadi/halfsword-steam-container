# UTM Setup - Completely Free & Open Source Windows 11 on Your M1 Max

**This is 100% free and open source** (no paid software, no subscriptions, no trials that nag you).

- UTM: https://github.com/utmapp/UTM (or https://mac.getutm.app/)
- Uses Apple's free Hypervisor framework + QEMU (open source).
- Perfect for a "contained Windows environment" without Parallels.

**Limitation for games**: UTM does not provide hardware 3D acceleration (DirectX) for Windows guests on Apple Silicon. Half Sword will run with software rendering. It may be playable at low settings/resolution, but expect lower FPS than translation layers or cloud. For best free local play, consider GeForce NOW (Half Sword is supported on the free tier with queues) or the last Whisky build.

This gives you a full Windows 11 desktop you can treat like a container/VM.

## What I Did For You (Free OSS Path)

- Opened direct pages:
  - UTM download: https://mac.getutm.app/
  - Official Microsoft Windows 11 Arm64 ISO: https://www.microsoft.com/en-us/software-download/windows11arm64
  - dockur/windows (the original container project): https://github.com/dockur/windows

- Your existing `docker-compose.macos-try.yml` is already a free open source "Windows container" using dockur (we tuned it for macOS).

- Created this guide and prepared folders (`~/HalfSword-Shared` is still usable for UTM too — UTM supports shared directories).

Run this for checklist:
```bash
bash /Users/ustad/halfsword-steam-container/setup-parallels-env.sh
```
(It works for any VM — it preps the shared folder.)

## Step-by-Step: Install Windows 11 ARM in UTM (Free)

### 1. Download UTM (Free & Open Source)
- Go to https://mac.getutm.app/ (or GitHub releases for the latest).
- Download the .dmg (the website version is completely free and open source).
- Open the .dmg and drag UTM to your Applications folder.
- Launch UTM.

(The Mac App Store version costs $10 for auto-updates/support, but the website/GitHub one is 100% free.)

### 2. Get Windows 11 ARM ISO (Official from Microsoft, Free)
- Go to: https://www.microsoft.com/en-us/software-download/windows11arm64
- Select the latest version (e.g., Windows 11 2025 Update or current).
- Download the multi-edition ISO for Arm-based PCs.
- It will be a large ~5-6 GB file. Save it somewhere easy (e.g., Downloads or the HalfSword-Shared folder).

Alternative tool for easier/fresher ISOs: CrystalFetch (mentioned in UTM docs) or the scripts in the UTM GitHub discussion.

### 3. Create the VM in UTM
1. Open UTM.
2. Click the **+** button to create a new VM.
3. Choose **Virtualize** (for best performance on Apple Silicon) > **Windows**.
4. Select the Windows 11 ARM ISO you downloaded.
5. Configure:
   - **Architecture**: ARM64 (it should detect).
   - **Memory**: Give it **16 GB** or **24 GB** (you have 64 GB total — plenty; start with 16-24, you can change later).
   - **CPU Cores**: 6 or 8 (M1 Max has 10 total; leave some for macOS).
   - **Storage**: 80 GB or 128 GB (dynamic).
   - **Display**: Default or higher resolution.
   - **Network**: Shared (default) or Bridged if you want.
   - Check **Install Windows** or follow the wizard.
6. UTM will create the VM. It may take time to install Windows the first time (it will boot from the ISO and install).

### 4. Post-Install in Windows
- Complete the Windows 11 setup (you can use a local account if you want).
- **Important for performance/integration**: Install SPICE tools / UTM tools if prompted (UTM usually mounts a CD with drivers).
  - Go to UTM menu > **Install Windows Guest Tools** or similar.
- Inside Windows, install **Steam** (normal Windows version).
- Log in and install **Half Sword**.

### 5. Shared Folder (for easy file transfer)
UTM supports shared directories:
- In UTM, edit the VM (stop it first) → **Drives** or **Sharing** section.
- Add a shared directory pointing to `/Users/ustad/HalfSword-Shared`.
- Inside Windows it will appear as a network share or mapped drive (you may need to enable file sharing in Windows or use the SPICE agent).

This is the same folder we prepared earlier — perfect for mods, configs, saves.

### 6. Performance Tips for Your M1 Max
- Allocate more RAM/cores if the game feels slow (edit VM while shut down).
- Run in full screen.
- For Half Sword: Lower resolution (e.g. 1280x800 or 1600x900), lowest/medium settings, disable VSync, lower shadow/particle quality.
- Since no hardware GPU accel in Windows guest, expect software-rendered performance. It may be 20-40 FPS at low settings in lighter scenes.
- If it's too slow for gaming, use the VM for other Windows things and play Half Sword via:
  - GeForce NOW (easiest free way — game is supported).
  - Or set up a Linux VM in UTM + Steam + Proton (Linux guests have better experimental GPU support via Virgl in UTM).

### Changing Resources Later
- Shut down the VM completely.
- In UTM, right-click the VM → Edit.
- Adjust RAM, CPU, etc.
- Start again.

## Alternative: The Docker "Windows Container" We Already Have (Also 100% Free OSS)

We prepared `docker-compose.macos-try.yml` using **dockur/windows** (https://github.com/dockur/windows — fully open source).

It runs Windows inside Docker (QEMU under the hood).

**To use it (slow on macOS but works as a true container):**

```bash
cd /Users/ustad/halfsword-steam-container
docker compose -f docker-compose.macos-try.yml up -d
```

- Access via browser: http://localhost:8006
- It auto-installs Windows 11.
- The oem/install.bat we included downloads SteamSetup.exe to the desktop.
- Run it inside the "VM", install Steam, install Half Sword.
- Ports: 8006 (web), 3389 (RDP).

**Note on speed**: On macOS Docker it uses emulation (no real KVM), so it's slower than UTM. Good for the "container" experience you originally asked for. Use it if you like the Docker workflow.

Run the helper script for more details:
```bash
bash setup-parallels-env.sh
```

## For Actually Playing Half Sword (Free + Best Performance)

Since full Windows in UTM has limited 3D for games:

1. **GeForce NOW** (easiest, completely free tier available):
   - Half Sword is officially supported.
   - Stream from cloud — high settings, no local install or performance hit on your Mac.
   - https://play.geforcenow.com/ (sign in with Steam).

2. Last Whisky build (free, though project is archived):
   - Download last release from GitHub: https://github.com/Whisky-App/Whisky/releases (or mirrors).
   - Half Sword demo is Platinum rated.
   - Many M1 Max users got good FPS with it before it was archived.
   - If it works for you, great. Otherwise fall back to cloud.

## Summary - Free & Open Source Only

- **Full Windows "container/VM"**: UTM (recommended) or the dockur Docker setup in this folder.
- **Play the game locally**: Whisky (last version) or UTM + low settings.
- **Play the game with zero hassle + good perf**: GeForce NOW (free).

All links above are official and free.

If you want me to create more scripts (e.g., a one-click UTM VM creator if possible, or config files for Half Sword), improve the Docker compose further, or focus on setting up a Linux VM + Proton in UTM for better game compatibility, just tell me.

Your M1 Max 64GB can handle any of these well.

Run the helper script and pick UTM or the Docker container. Both are completely free and open source. 

Let me know what to do next! ⚔️