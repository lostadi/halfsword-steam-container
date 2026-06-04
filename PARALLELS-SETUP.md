# Parallels Desktop Setup for Half Sword (M1 Max 64GB)

**Note: You want only open source and completely free. Parallels is proprietary/paid, so this is kept for reference only and is NOT the path for you.**

Use instead:
- **UTM-SETUP.md** → Best completely free + open source full Windows VM.
- The dockur files (docker-compose.macos-try.yml) → True open source "Windows container".

I have already prepared the shared folder (`~/HalfSword-Shared`), the helper script, and opened the free download pages.

Run this for your current checklist:
```bash
bash /Users/ustad/halfsword-steam-container/setup-parallels-env.sh
```

(The rest of this file is legacy reference only.)

From real user reports on M1 Max:
- Half Sword runs via CrossOver/Whisky at 30-60 FPS depending on settings.
- Parallels will be a bit heavier (full OS overhead) but very usable, especially with 24-32 GB RAM + 6 cores allocated.

**Direct links (also opened in browser):**
- 14-day Pro Trial (recommended): https://www.parallels.com/products/desktop/trial/
- Main download: https://www.parallels.com/products/desktop/download/

## Step 1: Install Parallels Desktop

Parallels is not installed on your Mac yet (I checked).

1. The trial page should already be open in your browser — click **Download Free Trial** (or the link above).
2. Download the .dmg from the official Parallels site (Pro edition for best gaming support).
3. Open the .dmg and install Parallels Desktop like a normal Mac app.
   - It will request Full Disk Access and other permissions — approve them.
4. Launch it and sign in (or create a free Parallels account) to activate the 14-day trial.

**Note**: Use the version downloaded from the website (not the limited App Store sandboxed edition) for full features and higher resource allocation.

## Quick Prep Script (run this)

```bash
bash /Users/ustad/halfsword-steam-container/setup-parallels-env.sh
```

It will re-confirm your shared folder and show the exact copy-paste settings.

**Note**: Parallels Desktop 19/20/26+ (whatever is current in 2026) fully supports M1/M-series with Windows on ARM.

## Step 2: Create the Windows 11 ARM Virtual Machine

1. In Parallels, click **+** (Create new virtual machine).
2. Choose **Windows 11** (it will offer to download Windows 11 ARM automatically — this is the easiest and recommended).
3. Follow the wizard:
   - Let it download the ARM version of Windows 11.
   - It will set up a basic VM for you.
4. Once created, **shut down** the VM completely before tweaking (important for hardware changes).

**Alternative**: If you already have a Windows 11 ARM ISO, you can use that.

## Step 3: Optimize VM Resources for Your M1 Max + 64 GB (Gaming Focused)

**I already created the shared folder for you at `~/HalfSword-Shared`.**

With 64 GB host RAM and M1 Max (10 CPU cores), we can be aggressive.

**Recommended allocation for Half Sword / gaming** (use these):
- **CPU cores**: 6 (sweet spot from tests on M1 Max — 6 cores often outperforms 4 or 8 for games)
- **RAM**: 24 GB (24576 MB) or 32 GB (you have the headroom)
- **Disk**: 128 GB or 160 GB (thin provisioning)
- Graphics: 3D acceleration ON

Detailed steps:

1. Make sure the VM is **shut down**.
2. Select the VM in Parallels → click the **gear icon** (Configure) or **Actions > Configure**.
3. Go to the **Hardware** tab:
   - **CPU & Memory**:
     - Set CPU to **6 cores**.
     - Set Memory (RAM) to **24576 MB** (24 GB) or **32768 MB** (32 GB).
   - **Graphics**:
     - Enable **3D acceleration**.
     - Set Video memory as high as allowed.
   - **Hard Disk**:
     - 128–160 GB.
4. Go to the **Options** tab:
   - **General**:
     - Under "Profile", select **Games only** (this is the most important setting for gaming performance).
   - **Sharing**:
     - Add the folder `/Users/ustad/HalfSword-Shared` (already exists on your Mac side — it will appear inside Windows for easy mod/save transfers).
   - **Applications**: Enable sharing if you like Coherence (Windows apps floating on macOS).
5. Click OK / Apply.
6. Start the VM.

**Pro tip from Parallels KB and users**: The "Games only" profile automatically tunes many things for better gaming perf and changes some sharing settings.

## Step 4: Complete Windows Setup

- Windows 11 ARM will boot and do its initial setup.
- Parallels Tools should install automatically (or prompt you) — this gives:
  - Shared folders
  - Better graphics/performance
  - Mouse/keyboard integration
  - Clipboard sharing
  - Dynamic resolution
- Install any Windows updates.

Inside Windows, set:
- Power plan → **Best performance**
- Disable unnecessary startup apps (search "Startup apps" in Windows settings).

## Step 5: Install Steam + Half Sword

1. In the Windows VM, open Microsoft Edge (or whatever browser).
2. Go to https://store.steampowered.com/about/
3. Download and run the Steam installer (normal Windows version).
4. Log into your Steam account.
5. Search for **Half Sword** and install it (start with the demo or playtest if available to test quickly).
6. Once installed, launch the game.

**File sharing tip**:
- Set up a shared folder from Mac side (e.g., `~/HalfSword-Shared`).
- In Windows it will be accessible (usually `\\Mac\Shared` or mapped drive).
- Great for dropping in mods, configs, or pulling out saves/screenshots.

## Step 6: Performance Tuning for Half Sword

Half Sword is physics/combat focused (ragdoll swords) — benefits from good CPU allocation (which we did) and decent GPU.

In Parallels:
- Play in **full screen** mode for best performance (or windowed if you want to switch easily).
- Use the "Games only" profile.

In the game (first launch):
- Start on **Medium** or **High** settings.
- Resolution: Try 1920x1200 or native Retina-scaled.
- Turn **V-Sync off**.
- Users on M1 Max report playable frame rates (expect 30-50+ FPS depending on scene density; physics sim can be CPU heavy).

General Windows tweaks:
- In Windows Settings → System → Display → set proper scaling.
- Close background apps in Windows.
- In Parallels menu (while VM running): Actions > **Tune for performance** or similar if available.

If performance is lower than expected:
- Try bumping to 8 cores / 32 GB RAM (shut down first).
- Make sure host Mac has plenty of free storage (Parallels VMs are sensitive to this).
- Update Parallels to the latest version.
- In game, lower shadow/particle effects if needed (common for UE games in VMs).

## Coherence Mode vs Full VM (for "container" feel)

- **Full screen / windowed VM**: Feels most like a separate Windows PC (what most people use for gaming).
- **Coherence mode**: Windows apps float like native Mac apps (you can run Steam or the game without seeing the full Windows desktop). Good for a more "contained" app-like experience.
  - Enable via Parallels menu when VM is running.

You can switch between them easily.

## Storage & Management

- The VM disk lives on your Mac (usually in `~/Parallels/` or similar).
- You can pause/suspend the VM instead of shutting down for fast resume.
- To "nuke and start over": Delete the VM from Parallels (or remove the .pvm file).

## How This Compares to the Docker Container We Made

The `docker-compose.macos-try.yml` (dockur/windows) will work but will be slower due to nested emulation (macOS → Docker Linux → QEMU Windows x86).
Parallels is **native Apple Silicon virtualization** with direct Metal graphics support → much better performance and integration.
This is the way to go on your M1 Max for a real Windows environment.

(If you later get a Linux box with KVM, the original `docker-compose.yml` becomes excellent.)

## Next Steps After Setup

1. Get Windows + Steam + Half Sword running.
2. Test the game.
3. Report back with FPS / how it feels — I can help with specific in-game tweaks, launch options, or config files (e.g., Engine.ini for Half Sword).
4. Want shared folder setup automated or a post-install script for common runtimes inside Windows? I can add that to the folder.

You now have a proper contained Windows environment tuned for your beast of a Mac.

Fire up Parallels and let's get this going. If you hit any screen during install, describe it and I'll guide you through.

Ready when you are — start with downloading Parallels! ⚔️
